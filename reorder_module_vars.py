import os, re, glob

HEADER_ORDER = ["name","author","discord","version","desc","showcase"]
BOM = b"\xef\xbb\xbf"
pattern = re.compile(r'^\s*MODULE\.([A-Za-z0-9_]+)')

def capture_blocks(lines):
    blocks = []
    i = 0
    while i < len(lines):
        line = lines[i]
        m = pattern.match(line)
        if not m:
            i += 1
            continue
        key = m.group(1)
        start = i
        block = [line]
        brace = line.count('{') - line.count('}')
        i += 1
        while brace > 0 and i < len(lines):
            block.append(lines[i])
            brace += lines[i].count('{') - lines[i].count('}')
            i += 1
        blocks.append((start, i, key, block))
    return blocks

def reorder_file(path):
    with open(path, 'rb') as f:
        data = f.read()
    has_bom = data.startswith(BOM)
    text = data.decode('utf-8-sig')
    lines = text.splitlines(True)

    blocks = capture_blocks(lines)
    if not blocks:
        return
    remove_indices = set()
    for s,e,_,_ in blocks:
        remove_indices.update(range(s,e))
    insert_pos = min(s for s,_,_,_ in blocks)

    or_blocks = []
    header_blocks = {k: [] for k in HEADER_ORDER}
    other_simple = []
    table_blocks = []
    public_block = None
    for b in blocks:
        key = b[2].lower()
        first = b[3][0]
        if re.search(r'=\s*MODULE\.[^\s]+\s*or\s*{', first):
            or_blocks.append(b)
        elif key in HEADER_ORDER:
            header_blocks[key].append(b)
        elif key == 'public':
            public_block = b
        elif re.search(r'=\s*{', first):
            table_blocks.append(b)
        else:
            other_simple.append(b)

    ordered = []
    ordered.extend(or_blocks)
    for key in HEADER_ORDER:
        ordered.extend(header_blocks[key])
    ordered.extend(other_simple)
    ordered.extend(table_blocks)
    if public_block:
        ordered.append(public_block)

    new_lines = []
    for idx in range(insert_pos):
        if idx not in remove_indices:
            new_lines.append(lines[idx])
    for _,_,_,block in ordered:
        new_lines.extend(block)
    for idx in range(insert_pos, len(lines)):
        if idx not in remove_indices:
            new_lines.append(lines[idx])

    out = ''.join(new_lines)
    with open(path, 'wb') as f:
        if has_bom:
            f.write(BOM)
        f.write(out.encode('utf-8'))

if __name__ == '__main__':
    for module in glob.glob('*/module.lua'):
        reorder_file(module)
