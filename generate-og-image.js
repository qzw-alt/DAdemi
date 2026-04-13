const { createCanvas, loadImage } = require('canvas');
const fs = require('fs');
const path = require('path');

// Canvas dimensions
const WIDTH = 1200;
const HEIGHT = 630;

// Create canvas
const canvas = createCanvas(WIDTH, HEIGHT);
const ctx = canvas.getContext('2d');

// Helper function to create gradient
function createGradient(ctx, x1, y1, x2, y2, stops) {
    const grad = ctx.createLinearGradient(x1, y1, x2, y2);
    stops.forEach(stop => grad.addColorStop(stop.pos, stop.color));
    return grad;
}

// Helper function to draw rounded rect
function drawRoundedRect(ctx, x, y, w, h, r) {
    ctx.beginPath();
    ctx.moveTo(x + r, y);
    ctx.lineTo(x + w - r, y);
    ctx.quadraticCurveTo(x + w, y, x + w, y + r);
    ctx.lineTo(x + w, y + h - r);
    ctx.quadraticCurveTo(x + w, y + h, x + w - r, y + h);
    ctx.lineTo(x + r, y + h);
    ctx.quadraticCurveTo(x, y + h, x, y + h - r);
    ctx.lineTo(x, y + r);
    ctx.quadraticCurveTo(x, y, x + r, y);
    ctx.closePath();
}

// Draw background gradient
const bgGradient = createGradient(ctx, 0, 0, WIDTH, HEIGHT, [
    { pos: 0, color: '#667eea' },
    { pos: 1, color: '#764ba2' }
]);
ctx.fillStyle = bgGradient;
ctx.fillRect(0, 0, WIDTH, HEIGHT);

// Draw decorative circles (subtle background elements)
ctx.fillStyle = 'rgba(255, 255, 255, 0.05)';
ctx.beginPath();
ctx.arc(900, -100, 400, 0, Math.PI * 2);
ctx.fill();

ctx.fillStyle = 'rgba(255, 255, 255, 0.03)';
ctx.beginPath();
ctx.arc(100, 500, 300, 0, Math.PI * 2);
ctx.fill();

// Helper function to draw cross/plus symbol
function drawCross(ctx, x, y, size, color) {
    ctx.strokeStyle = color;
    ctx.lineWidth = size / 4;
    ctx.lineCap = 'round';
    ctx.beginPath();
    ctx.moveTo(x - size/2, y);
    ctx.lineTo(x + size/2, y);
    ctx.moveTo(x, y - size/2);
    ctx.lineTo(x, y + size/2);
    ctx.stroke();
}

// Helper function to draw heart
function drawHeart(ctx, x, y, size, color) {
    ctx.fillStyle = color;
    ctx.beginPath();
    const topCurveHeight = size * 0.3;
    ctx.moveTo(x, y + topCurveHeight);
    ctx.bezierCurveTo(
        x, y,
        x - size / 2, y,
        x - size / 2, y + topCurveHeight
    );
    ctx.bezierCurveTo(
        x - size / 2, y + (size + topCurveHeight) / 2,
        x, y + (size + topCurveHeight) / 2,
        x, y + size
    );
    ctx.bezierCurveTo(
        x, y + (size + topCurveHeight) / 2,
        x + size / 2, y + (size + topCurveHeight) / 2,
        x + size / 2, y + topCurveHeight
    );
    ctx.bezierCurveTo(
        x + size / 2, y,
        x, y,
        x, y + topCurveHeight
    );
    ctx.closePath();
    ctx.fill();
}

// Helper function to draw stethoscope
function drawStethoscope(ctx, x, y, size, color) {
    ctx.strokeStyle = color;
    ctx.lineWidth = size / 8;
    ctx.lineCap = 'round';
    
    // Ear pieces
    ctx.beginPath();
    ctx.arc(x - size/3, y - size/3, size/6, Math.PI, 0);
    ctx.stroke();
    
    // Chest piece
    ctx.fillStyle = color;
    ctx.beginPath();
    ctx.arc(x + size/3, y + size/4, size/5, 0, Math.PI * 2);
    ctx.fill();
    
    // Tube
    ctx.beginPath();
    ctx.moveTo(x - size/3, y - size/6);
    ctx.quadraticCurveTo(x, y, x + size/3, y + size/4 - size/5);
    ctx.stroke();
}

// Helper function to draw airplane
function drawAirplane(ctx, x, y, size, color) {
    ctx.fillStyle = color;
    ctx.save();
    ctx.translate(x, y);
    ctx.rotate(-Math.PI / 6);
    
    // Fuselage
    ctx.beginPath();
    ctx.ellipse(0, 0, size/2, size/8, 0, 0, Math.PI * 2);
    ctx.fill();
    
    // Left wing
    ctx.beginPath();
    ctx.moveTo(-size/6, 0);
    ctx.lineTo(-size/3, size/3);
    ctx.lineTo(-size/8, size/4);
    ctx.closePath();
    ctx.fill();
    
    // Right wing
    ctx.beginPath();
    ctx.moveTo(-size/6, 0);
    ctx.lineTo(-size/3, -size/3);
    ctx.lineTo(-size/8, -size/4);
    ctx.closePath();
    ctx.fill();
    
    ctx.restore();
}

// Helper function to draw shield
function drawShield(ctx, x, y, size, color) {
    ctx.fillStyle = color;
    ctx.beginPath();
    ctx.moveTo(x, y - size/2);
    ctx.quadraticCurveTo(x + size/2, y - size/2, x + size/2, y);
    ctx.quadraticCurveTo(x + size/2, y + size/2, x, y + size/2);
    ctx.quadraticCurveTo(x - size/2, y + size/2, x - size/2, y);
    ctx.quadraticCurveTo(x - size/2, y - size/2, x, y - size/2);
    ctx.closePath();
    ctx.fill();
}

// Helper function to draw checkmark
function drawCheckmark(ctx, x, y, size, color) {
    ctx.strokeStyle = color;
    ctx.lineWidth = size / 4;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    ctx.beginPath();
    ctx.moveTo(x - size/2, y);
    ctx.lineTo(x - size/6, y + size/2);
    ctx.lineTo(x + size/2, y - size/2);
    ctx.stroke();
}

// Logo area (top left)
ctx.fillStyle = 'white';
drawRoundedRect(ctx, 60, 40, 50, 50, 12);
ctx.fill();

// Draw hospital cross icon
drawCross(ctx, 85, 65, 24, '#667eea');

// Logo text
ctx.font = '600 24px "Segoe UI", Arial, sans-serif';
ctx.fillStyle = 'white';
ctx.textAlign = 'left';
ctx.fillText('China Hospitals Guide', 125, 68);

// Medical icons (top right) - drawn with shapes instead of emoji
const iconBg = 'rgba(255, 255, 255, 0.15)';
const icons = [
    { draw: (ctx, x, y) => drawHeart(ctx, x, y, 28, 'white') },
    { draw: (ctx, x, y) => drawStethoscope(ctx, x, y, 32, 'white') },
    { draw: (ctx, x, y) => drawAirplane(ctx, x, y, 28, 'white') }
];
icons.forEach((icon, i) => {
    const x = WIDTH - 240 + i * 80;
    ctx.fillStyle = iconBg;
    drawRoundedRect(ctx, x, 40, 60, 60, 15);
    ctx.fill();
    
    icon.draw(ctx, x + 30, 70);
});

// Main headline
ctx.textAlign = 'center';
ctx.font = '800 72px "Segoe UI", Arial, sans-serif';
ctx.fillStyle = 'white';
ctx.shadowColor = 'rgba(0, 0, 0, 0.2)';
ctx.shadowBlur = 20;
ctx.shadowOffsetX = 0;
ctx.shadowOffsetY = 4;
ctx.fillText('World-Class Healthcare', WIDTH / 2, 220);
ctx.fillText('at 50-80% Lower Costs', WIDTH / 2, 300);

// Reset shadow
ctx.shadowColor = 'transparent';

// Subheadline
ctx.font = '400 32px "Segoe UI", Arial, sans-serif';
ctx.fillStyle = 'rgba(255, 255, 255, 0.95)';
ctx.fillText('Your trusted guide to top hospitals in', WIDTH / 2, 370);
ctx.fillText('Beijing, Shanghai, Guangzhou & Shenzhen', WIDTH / 2, 410);

// Stats bar
const stats = [
    { number: '40+', label: 'Partner Hospitals' },
    { number: '500+', label: 'Patients Helped' },
    { number: '98%', label: 'Satisfaction Rate' }
];

const statsY = 500;
const statsSpacing = 200;
const startX = WIDTH / 2 - ((stats.length - 1) * statsSpacing) / 2;

stats.forEach((stat, i) => {
    const x = startX + i * statsSpacing;
    
    // Number
    ctx.font = '800 48px "Segoe UI", Arial, sans-serif';
    ctx.fillStyle = 'white';
    ctx.textAlign = 'center';
    ctx.fillText(stat.number, x, statsY);
    
    // Label
    ctx.font = '400 18px "Segoe UI", Arial, sans-serif';
    ctx.fillStyle = 'rgba(255, 255, 255, 0.9)';
    ctx.fillText(stat.label, x, statsY + 30);
});

// CTA Badge (bottom right)
ctx.fillStyle = '#ff6b6b';
drawRoundedRect(ctx, WIDTH - 320, HEIGHT - 100, 280, 50, 25);
ctx.fill();

// Draw shield icon
drawShield(ctx, WIDTH - 300, HEIGHT - 75, 18, 'white');
drawCheckmark(ctx, WIDTH - 300, HEIGHT - 75, 12, '#ff6b6b');

ctx.font = '700 18px "Segoe UI", Arial, sans-serif';
ctx.fillStyle = 'white';
ctx.textAlign = 'left';
ctx.textBaseline = 'middle';
ctx.fillText('100% Satisfaction Guarantee', WIDTH - 280, HEIGHT - 75);

// Save as JPEG
const buffer = canvas.toBuffer('image/jpeg', { quality: 0.95 });
fs.writeFileSync('og-image.jpg', buffer);

console.log('✅ Image saved as og-image.jpg');
console.log(`📐 Dimensions: ${WIDTH}x${HEIGHT}px`);
