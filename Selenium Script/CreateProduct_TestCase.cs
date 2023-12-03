using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Support.UI;
using System;
using System.Text;

class Program
{
    static IWebDriver driver;

    static void Main()
    {
        driver = new ChromeDriver();

        // Mở trang web và đăng nhập vào hệ thống (nếu cần)
        Login("chibao", "0000");

        // Thực hiện thêm sản phẩm
        //Test 1: Tất cả các trường đều trống
        AddProduct("", "", 0, 0, 0, 0, "", "", "");
        //Test 2: Tất cả các trường đều nhập đúng định dạng
        AddProduct("Guitar X", "GUITAR", 10, 20, 30, 500, "C:\\Users\\chiba\\source\\repos\\CreateProduct_TestCase\\CreateProduct_TestCase\\Images\\Fu_test1.png", "C:\\Users\\chiba\\source\\repos\\CreateProduct_TestCase\\CreateProduct_TestCase\\Images\\Fu_test2.png", "X");
        // Test 3: Kích cỡ bị âm
        AddProduct("Harmonica Y", "HARMONICA", -10, -20, -30, 300, "C:\\Users\\chiba\\source\\repos\\CreateProduct_TestCase\\CreateProduct_TestCase\\Images\\Fu_test1.png", "C:\\Users\\chiba\\source\\repos\\CreateProduct_TestCase\\CreateProduct_TestCase\\Images\\Fu_test2.png", "Y");
        // Test 4: Gía bị âm
        AddProduct("Drum Z", "DRUM", 10, 20, 30, -100, "C:\\Users\\chiba\\source\\repos\\CreateProduct_TestCase\\CreateProduct_TestCase\\Images\\Na_test1.png", "C:\\Users\\chiba\\source\\repos\\CreateProduct_TestCase\\CreateProduct_TestCase\\Images\\Na_test2.png", "Z");
        //Test 5: Đường dẫn bị sai
        AddProduct("Violin T", "VIOLIN", 10, 20, 30, 500, "D:\\Na_test1.png", "D:\\Na_test2.png", "T");
        // Test 6: Phụ kiện 
        AddProduct("Phụ kiện W", "PHỤ KIỆN", 999, 999, 999, 999, "C:\\Users\\chiba\\source\\repos\\CreateProduct_TestCase\\CreateProduct_TestCase\\Images\\Na_test1.png", "C:\\Users\\chiba\\source\\repos\\CreateProduct_TestCase\\CreateProduct_TestCase\\Images\\Na_test2.png", "W");


        // Đóng trình duyệt
        //driver.Quit();
    }

    static void Login(string username, string password)
    {
        driver.Navigate().GoToUrl("https://localhost:44385/login");

        // Nhập thông tin đăng nhập và click nút đăng nhập
        driver.FindElement(By.Id("email-cus")).SendKeys(username);
        driver.FindElement(By.Id("password-cus")).SendKeys(password);
        driver.FindElement(By.CssSelector(".button-login")).Click();
    }

    static void AddProduct(string productName, string category, int sizeS, int sizeM, int sizeL, int price, string img1Path, string img2Path, string description)
    {
        // Chuyển đến trang thêm sản phẩm
        driver.Navigate().GoToUrl("https://localhost:44385/Admin/Products/create");

        // Kiểm tra ràng buộc trước khi thêm sản phẩm
        if (price < 0 || sizeS < 0 || sizeM < 0 || sizeL < 0 || string.IsNullOrWhiteSpace(img1Path) || string.IsNullOrWhiteSpace(img2Path))
        {
            Console.OutputEncoding = Encoding.UTF8;
            Console.WriteLine($"Sản phẩm '{productName}' bị lỗi. Bỏ qua và thử trường hợp tiếp theo.");
            return;
        }

        // Nhập thông tin sản phẩm
        driver.FindElement(By.Name("nameProduct")).SendKeys(productName);

        // Chọn danh mục sử dụng SelectElement
        IWebElement categoryDropdown = driver.FindElement(By.Name("idType"));
        SelectElement selectCategory = new SelectElement(categoryDropdown);
        selectCategory.SelectByText(category);

        driver.FindElement(By.Name("sizeS")).SendKeys(sizeS.ToString());
        driver.FindElement(By.Name("sizeM")).SendKeys(sizeM.ToString());
        driver.FindElement(By.Name("sizeL")).SendKeys(sizeL.ToString());
        driver.FindElement(By.Name("price")).SendKeys(price.ToString());

        // Xử lý ảnh 1
        try
        {
            driver.FindElement(By.Name("img1")).SendKeys(img1Path);
        }
        catch (Exception ex)
        {
            Console.OutputEncoding = Encoding.UTF8;
            Console.WriteLine($"Lỗi khi thêm ảnh 1 cho sản phẩm '{productName}': {ex.Message}");
            Console.WriteLine($"Bỏ qua và thử trường hợp tiếp theo.");
            return;
        }

        // Xử lý ảnh 2
        try
        {
            driver.FindElement(By.Name("img2")).SendKeys(img2Path);
        }
        catch (Exception ex)
        {
            Console.OutputEncoding = Encoding.UTF8;
            Console.WriteLine($"Lỗi khi thêm ảnh 2 cho sản phẩm '{productName}': {ex.Message}");
            Console.WriteLine($"Bỏ qua và thử trường hợp tiếp theo.");
            return;
        }

        driver.FindElement(By.Name("description")).SendKeys(description);

        // Ở đây ta phải dùng JS để xử lý click bởi vì các phần tử chồng chéo lên nhau
        IWebElement button = driver.FindElement(By.CssSelector("button.btn.btn-primary"));
        ((IJavaScriptExecutor)driver).ExecuteScript("window.scrollBy(0, 200);");
        ((IJavaScriptExecutor)driver).ExecuteScript("arguments[0].click();", button);

        // Kiểm tra xem sản phẩm đã được thêm thành công hay không và xuất ra console
        if (IsProductAddedSuccessfully())
        {
            Console.OutputEncoding = Encoding.UTF8;
            Console.WriteLine($"Thêm: '{productName}' thất bại!");
        }
        else
        {
            Console.OutputEncoding = Encoding.UTF8;
            Console.WriteLine($"Thêm '{productName}' thành công.");
        }
    }

    static bool IsProductAddedSuccessfully()
    {
        // Kiểm tra xem đã chuyển hướng đến trang quản lý sản phẩm hay không
        return driver.Url.Contains("https://localhost:44385/Admin/Products/Index");
    }
}
