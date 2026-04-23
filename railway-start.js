const { execSync } = require('child_process');

console.log('🚀 Starting command deployment...');
try {
  execSync('node slashbuilder.js', { stdio: 'inherit' });
  console.log('✅ Commands deployed successfully!');
} catch (error) {
  console.error('❌ Failed to deploy commands:', error.message);
}

console.log('🎵 Starting bot...');
require('./index.js');
