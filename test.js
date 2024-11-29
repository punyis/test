const { test, expect } = require('@playwright/test');

test.describe('VibeX Web Application', () => {
  
  test.beforeEach(async ({ page }) => {
    // เปิดเว็บแอปพลิเคชัน
    await page.goto('http://localhost:3000'); // เปลี่ยน URL ตามแอปของคุณ
  });

  test('ตรวจสอบการแสดงผลหน้าแรก', async ({ page }) => {
    // ตรวจสอบว่ามีข้อความ VibeX
    await expect(page.locator('h1')).toHaveText('VibeX');
    
    // ตรวจสอบกล่องค้นหา
    await expect(page.locator('input[placeholder="Search posts by title"]')).toBeVisible();
  });

  test('เข้าสู่ระบบและออกจากระบบ', async ({ page }) => {
    // คลิกที่ปุ่ม Log in
    await page.click('text=Log in');
    
    // กรอกอีเมลและรหัสผ่าน
    await page.fill('input[name="email"]', 'testuser@example.com');
    await page.fill('input[name="password"]', 'password123');
    await page.click('text=Log in');

    // ตรวจสอบว่าข้อความ Welcome แสดงผล
    await expect(page.locator('text=Welcome, testuser@example.com')).toBeVisible();

    // ออกจากระบบ
    await page.click('text=Log out');
    await expect(page.locator('text=Log in')).toBeVisible();
  });

  test('สร้างโพสต์ใหม่', async ({ page }) => {
    // เข้าสู่ระบบ
    await page.click('text=Log in');
    await page.fill('input[name="email"]', 'testuser@example.com');
    await page.fill('input[name="password"]', 'password123');
    await page.click('text=Log in');

    // ไปที่หน้า New Post
    await page.click('text=New Post');
    
    // กรอกข้อมูลโพสต์
    await page.fill('input[name="post[title]"]', 'My First Post');
    await page.fill('textarea[name="post[content]"]', 'This is the content of my first post.');
    await page.click('text=Create Post');

    // ตรวจสอบว่ามีโพสต์ใหม่แสดงผล
    await expect(page.locator('text=My First Post')).toBeVisible();
  });

  test('แก้ไขโพสต์', async ({ page }) => {
    // เข้าสู่ระบบ
    await page.click('text=Log in');
    await page.fill('input[name="email"]', 'testuser@example.com');
    await page.fill('input[name="password"]', 'password123');
    await page.click('text=Log in');

    // คลิกเพื่อแก้ไขโพสต์
    await page.click('text=Edit Post');
    await page.fill('input[name="post[title]"]', 'Updated Post Title');
    await page.fill('textarea[name="post[content]"]', 'Updated content of the post.');
    await page.click('text=Update Post');

    // ตรวจสอบว่าโพสต์ถูกอัปเดตแล้ว
    await expect(page.locator('text=Updated Post Title')).toBeVisible();
  });
});
