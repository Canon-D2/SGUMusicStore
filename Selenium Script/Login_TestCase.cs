using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using System;
using System.Text;
using System.Threading;

class Program
{
    static IWebDriver driver;

    static void Main()
    {
        driver = new ChromeDriver();

        
        // Test Case 1: Trường hợp sai mật khẩu
        ExecuteTestCase("chibao", "wrong_password", "Test Case 1");

        // Test Case 2: Trường hợp tài khoản không tồn tại
        ExecuteTestCase("nonexistent_user", "0000", "Test Case 2");

        // Test Case 3: Trường hợp không điền tên đăng nhập
        ExecuteTestCase("", "0000", "Test Case 3");

        // Test Case 4: Trường hợp không điền mật khẩu
        ExecuteTestCase("chibao", "", "Test Case 4");

        // Test Case 5: Trường hợp đúng tài khoản và mật khẩu
        ExecuteTestCase("chibao", "0000", "Test Case 5");

        //driver.Quit();
    }

    static void ExecuteTestCase(string username, string password, string testCaseName)
    {
        driver.Navigate().GoToUrl("https://localhost:44385/login");
        driver.FindElement(By.Id("email-cus")).SendKeys(username);
        driver.FindElement(By.Id("password-cus")).SendKeys(password);
        driver.FindElement(By.CssSelector(".button-login")).Click();
        Thread.Sleep(2000);

        if (CheckStatus())
        {
            Console.OutputEncoding = Encoding.UTF8;
            Console.WriteLine($"{testCaseName}: Login Success!");
            // Đăng xuất để test tiếp tục
            driver.Navigate().GoToUrl("https://localhost:44385/login/signout");
            Console.WriteLine($"{testCaseName}: Logout, Continue!");
        }
        else
        {
            Console.WriteLine($"{testCaseName}: Login Failed!");
        }
    }

    static bool CheckStatus()
    {
        // Kiểm tra trạng thái sau khi đăng nhập (thành công hoặc thất bại) dựa trên URL hoặc các phần tử khác trên trang web
        return driver.Url.Contains("https://localhost:44385/Admin/Dashboard/Index");
    }
}
