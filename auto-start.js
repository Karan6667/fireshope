const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🚀 FireShop Auto-Start Server');
console.log('================================');

// Check if MongoDB is running
function checkMongoDB() {
    return new Promise((resolve) => {
        const mongod = spawn('mongod', ['--version'], { shell: true });
        mongod.on('close', (code) => {
            resolve(code === 0);
        });
        mongod.on('error', () => {
            resolve(false);
        });
    });
}

// Check if Node.js dependencies are installed
function checkDependencies() {
    return fs.existsSync(path.join(__dirname, 'node_modules'));
}

// Install dependencies
function installDependencies() {
    return new Promise((resolve, reject) => {
        console.log('📦 Installing dependencies...');
        const npm = spawn('npm', ['install'], { shell: true, stdio: 'inherit' });
        npm.on('close', (code) => {
            if (code === 0) {
                console.log('✅ Dependencies installed successfully!');
                resolve();
            } else {
                reject(new Error('Failed to install dependencies'));
            }
        });
    });
}

// Start the server
function startServer() {
    console.log('🌐 Starting FireShop server...');
    console.log('📍 Server will be available at: http://localhost:5000');
    console.log('📍 MongoDB Compass connection: mongodb://localhost:27017/fireshop');
    console.log('⏹️  Press Ctrl+C to stop the server');
    console.log('================================');
    
    const server = spawn('npm', ['run', 'dev'], { shell: true, stdio: 'inherit' });
    
    server.on('close', (code) => {
        console.log(`\n🛑 Server stopped with code ${code}`);
    });
    
    // Handle graceful shutdown
    process.on('SIGINT', () => {
        console.log('\n🛑 Shutting down server...');
        server.kill('SIGINT');
        process.exit(0);
    });
}

// Main function
async function main() {
    try {
        // Check MongoDB
        console.log('🔍 Checking MongoDB...');
        const mongoRunning = await checkMongoDB();
        if (!mongoRunning) {
            console.log('⚠️  Warning: MongoDB might not be installed or running');
            console.log('   Please ensure MongoDB is installed and running');
            console.log('   Download from: https://www.mongodb.com/try/download/community');
        } else {
            console.log('✅ MongoDB is available');
        }
        
        // Check dependencies
        console.log('🔍 Checking dependencies...');
        if (!checkDependencies()) {
            await installDependencies();
        } else {
            console.log('✅ Dependencies are installed');
        }
        
        // Start server
        startServer();
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        process.exit(1);
    }
}

main();
