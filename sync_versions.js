const fs = require('fs')
const path = require('path')

/**
 * Extracts version number from module.lua file
 * @param {string} modulePath - Path to module.lua file
 * @returns {string|null} - Version string (e.g., "1.4") or null if not found
 */
function extractModuleVersion(modulePath) {
  try {
    const content = fs.readFileSync(modulePath, 'utf8')
    const match = content.match(/MODULE\.version\s*=\s*([0-9]+(?:\.[0-9]+)?)/)
    if (match) {
      return match[1]
    }
  } catch (error) {
    console.error(`Error reading ${modulePath}:`, error.message)
  }
  return null
}

/**
 * Extracts the latest version from changelog.md file
 * @param {string} changelogPath - Path to changelog.md file
 * @returns {string|null} - Version string (e.g., "1.4") or null if not found
 */
function extractChangelogVersion(changelogPath) {
  try {
    const content = fs.readFileSync(changelogPath, 'utf8')
    // Match the first version header (which should be the latest)
    const match = content.match(/###\s+Version\s+([0-9]+(?:\.[0-9]+)?)/i)
    if (match) {
      return match[1]
    }
  } catch (error) {
    // Changelog might not exist, that's okay
    return null
  }
  return null
}

/**
 * Updates the version in module.lua to match the changelog version
 * @param {string} modulePath - Path to module.lua file
 * @param {string} newVersion - New version string to set
 * @returns {boolean} - True if update was successful
 */
function updateModuleVersion(modulePath, newVersion) {
  try {
    let content = fs.readFileSync(modulePath, 'utf8')
    // Replace the version line, handling both integer and float versions
    content = content.replace(
      /(MODULE\.version\s*=\s*)([0-9]+(?:\.[0-9]+)?)/,
      `$1${newVersion}`
    )
    fs.writeFileSync(modulePath, content, 'utf8')
    return true
  } catch (error) {
    console.error(`Error updating ${modulePath}:`, error.message)
    return false
  }
}

/**
 * Main function to sync all module versions with their changelogs
 * @param {boolean} dryRun - If true, only report mismatches without updating files
 * @returns {boolean} - Returns false if there are mismatches (for CI validation)
 */
function syncVersions(dryRun = false) {
  const rootDir = __dirname
  const entries = fs.readdirSync(rootDir, { withFileTypes: true })
  
  let totalModules = 0
  let syncedModules = 0
  let mismatchedModules = []
  let missingChangelogs = []
  
  for (const entry of entries) {
    if (!entry.isDirectory()) continue
    if (entry.name === '.git' || entry.name === 'node_modules' || entry.name === 'documentation') continue
    
    const moduleDir = path.join(rootDir, entry.name)
    const modulePath = path.join(moduleDir, 'module.lua')
    const changelogPath = path.join(moduleDir, 'docs', 'changelog.md')
    
    // Check if module.lua exists
    if (!fs.existsSync(modulePath)) continue
    
    totalModules++
    
    const moduleVersion = extractModuleVersion(modulePath)
    const changelogVersion = extractChangelogVersion(changelogPath)
    
    if (!changelogVersion) {
      missingChangelogs.push(entry.name)
      continue
    }
    
    if (!moduleVersion) {
      console.warn(`⚠️  ${entry.name}: Could not extract version from module.lua`)
      continue
    }
    
    // Compare versions (as strings first, then as numbers if needed)
    if (moduleVersion !== changelogVersion) {
      // Try to compare as numbers to handle cases like "1.4" vs "1.40"
      const moduleVersionNum = parseFloat(moduleVersion)
      const changelogVersionNum = parseFloat(changelogVersion)
      
        if (moduleVersionNum !== changelogVersionNum) {
          console.log(`🔄 ${entry.name}: Version mismatch (module: ${moduleVersion}, changelog: ${changelogVersion})`)
          mismatchedModules.push({
            name: entry.name,
            moduleVersion,
            changelogVersion
          })
          
          if (dryRun) {
            console.log(`   ⚠️  Would update module.lua to version ${changelogVersion} (dry run)`)
          } else {
            // Update module version to match changelog
            if (updateModuleVersion(modulePath, changelogVersion)) {
              console.log(`   ✅ Updated module.lua to version ${changelogVersion}`)
              syncedModules++
            } else {
              console.error(`   ❌ Failed to update module.lua`)
            }
          }
        }
    } else {
      // Versions match, no action needed
    }
  }
  
  // Summary
  console.log('\n' + '='.repeat(60))
  console.log('Version Sync Summary')
  console.log('='.repeat(60))
  console.log(`Total modules checked: ${totalModules}`)
  console.log(`Modules synced: ${syncedModules}`)
  console.log(`Modules already in sync: ${totalModules - syncedModules - mismatchedModules.length}`)
  
  if (missingChangelogs.length > 0) {
    console.log(`\n⚠️  Modules without changelog: ${missingChangelogs.length}`)
    missingChangelogs.forEach(name => console.log(`   - ${name}`))
  }
  
  if (mismatchedModules.length === 0 && missingChangelogs.length === 0) {
    console.log('\n✅ All module versions are in sync with their changelogs!')
    return true
  } else if (dryRun) {
    console.log(`\n❌ Found ${mismatchedModules.length} module(s) with version mismatches`)
    return false
  } else if (syncedModules > 0) {
    console.log(`\n✅ Successfully synced ${syncedModules} module(s)`)
    return true
  }
  
  return false
}

// Check command line arguments
const args = process.argv.slice(2)
const dryRun = args.includes('--dry-run') || args.includes('--validate')

// Run the sync
const success = syncVersions(dryRun)
process.exit(success ? 0 : 1)

