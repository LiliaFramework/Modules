#!/usr/bin/env python3
"""
Script to clean up docs directories in all modules.
Removes all files except changelog.md from each module's docs/ directory.
"""

import os
import shutil
from pathlib import Path

# Hardcoded path to the gitmodules directory
GITMODULES_PATH = r"E:\GMOD\Server\garrysmod\gamemodes\metrorp\gitmodules"

def cleanup_docs_directories():
    """
    Clean up all docs directories by removing all files except changelog.md
    """
    gitmodules_path = Path(GITMODULES_PATH)

    if not gitmodules_path.exists():
        print(f"Error: Path {GITMODULES_PATH} does not exist!")
        return

    print(f"Processing modules in: {GITMODULES_PATH}")
    print("=" * 50)

    # Get all directories (modules) in gitmodules
    modules_processed = 0
    files_removed_total = 0

    for item in gitmodules_path.iterdir():
        if item.is_dir():
            # Skip non-module directories
            if item.name in ['__pycache__', '.git']:
                continue

            docs_path = item / "docs"

            if docs_path.exists():
                print(f"\nProcessing {item.name}/docs/")

                files_removed = 0

                # Get all files in docs directory except changelog.md
                for file_path in docs_path.iterdir():
                    if file_path.is_file() and file_path.name != "changelog.md":
                        print(f"  Removing: {file_path.name}")
                        file_path.unlink()  # Remove the file
                        files_removed += 1

                if files_removed > 0:
                    print(f"  ✓ Removed {files_removed} files, kept changelog.md")
                    files_removed_total += files_removed
                else:
                    print("  ✓ No files to remove (only changelog.md present)")

                modules_processed += 1

    print("\n" + "=" * 50)
    print("CLEANUP COMPLETE!")
    print(f"• Modules processed: {modules_processed}")
    print(f"• Files removed: {files_removed_total}")
    print("• All changelog.md files preserved ✓")

if __name__ == "__main__":
    cleanup_docs_directories()
