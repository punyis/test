import { defineConfig } from '@playwright/test';

export default defineConfig({
  reporter: [['html', { open: 'never' }]], // กำหนดให้สร้าง HTML Report โดยไม่เปิดทันที
  use: {
    baseURL: 'http://127.0.0.1:3000', // URL ของเว็บแอปพลิเคชันของคุณ
    headless: true, // ตั้งค่าเป็น true หากไม่ต้องการแสดงหน้าต่าง browser
  },
});
