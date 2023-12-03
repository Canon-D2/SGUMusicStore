using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;

class Program
{
    static void Main()
    {
        IWebDriver driver = new ChromeDriver();

        driver.Navigate().GoToUrl("https://localhost:44385/cart");

        // Danh sách sản phẩm
        string productJson1 = "[{\"id\":0,\"title\":\"Guitar TAYLOR T5Z CLASSIC KOA\",\"price\":117,\"size\":\"L\",\"img\":\"https://localhost:44385/Images/guitar3a.jpg\",\"amount\":\"1\",\"idFood\":\"P03\"}]";
        string productJson2 = "[{\"id\":0,\"title\":\"Guitar TAYLOR T5Z CLASSIC KOA\",\"price\":-150,\"size\":\"M\",\"img\":\"https://localhost:44385/Images/guitar3a.jpg\",\"amount\":\"2\",\"idFood\":\"P03\"}]";
        string productJson3 = "[{\"id\":0,\"title\":\"Guitar TAYLOR T5Z CLASSIC KOA\",\"price\":117,\"size\":\"S\",\"img\":\"https://localhost:44385/Images/guitar3a.jpg\",\"amount\":\"0\",\"idFood\":\"P03\"}]";
        string productJson4 = "[{\"id\":0,\"title\":\"Guitar FENDER Stratocaster\",\"price\":-117,\"size\":\"L\",\"img\":\"https://localhost:44385/Images/guitar4a.jpg\",\"amount\":\"-1\",\"idFood\":\"P04\"}]";
        string productJson5 = "[{\"id\":0,\"title\":\"Guitar TAYLOR T5Z CLASSIC KOA\",\"price\":200,\"size\":\"Q\",\"img\":\"https://localhost:44385/Images/guitar5a.jpg\",\"amount\":\"2\",\"idFood\":\"P05\"}]";
        string emptyProductJson = "[]";

        // TestCase 1 - SP1: SL > 0, GIÁ > 0
        AddProductToCart(driver, productJson1, "Test Case 1");
        ClearCartAndReturnToCartPage(driver);

        // TestCase 2 - SP2: SL > 0, GIÁ < 0
        AddProductToCart(driver, productJson2, "Test Case 2");
        ClearCartAndReturnToCartPage(driver);

        // TestCase 3 - SP3: SL < 0, GIÁ = 0
        AddProductToCart(driver, productJson3, "Test Case 3");
        ClearCartAndReturnToCartPage(driver);

        // TestCase 4 - SP khác tên, SL < 0, GIÁ < 0
        AddProductToCart(driver, productJson4, "Test Case 4");
        ClearCartAndReturnToCartPage(driver);

        // TestCase 5 - Sai mã Kích cỡ Size SL > 0, GIÁ > 0
        AddProductToCart(driver, productJson5, "Test Case 5");
        ClearCartAndReturnToCartPage(driver);

        // TestCase 6 - Giỏ hàng trống
        AddProductToCart(driver, emptyProductJson, "Test Case 6");
        ClearCartAndReturnToCartPage(driver);

        //driver.Quit();
    }

    static void AddProductToCart(IWebDriver driver, string productJson, string testCaseName)
    {
        // Chuyển chuỗi JSON thành đối tượng
        List<Dictionary<string, object>> productData = Newtonsoft.Json.JsonConvert.DeserializeObject<List<Dictionary<string, object>>>(productJson);

        // Inject JavaScript để thêm sản phẩm vào trang
        string script = $"localStorage.setItem('cart', '{productJson}'); location.reload();";
        IJavaScriptExecutor js = (IJavaScriptExecutor)driver;
        js.ExecuteScript(script);

        // Đợi một chút để trang cập nhật
        Thread.Sleep(2000);

        // Tìm nút không phải theo id mà theo class
        IWebElement checkoutButton = driver.FindElement(By.ClassName("button-payment"));
        checkoutButton.Click();

        // Đợi một chút để trang cập nhật
        Thread.Sleep(2000);

        // Kiểm tra xem tổng tiền có hiển thị đúng không
        IWebElement totalMoneyElement = driver.FindElement(By.Id("totalMoney"));
        string totalMoneyText = totalMoneyElement.Text;

        if (productData.Count > 0)
        {
            string expectedTotalMoney = productData[0]["price"] + ",000 VND";
            Console.OutputEncoding = Encoding.UTF8;
            Console.WriteLine($"{testCaseName}: Total Bill (+Ship) {totalMoneyText}, Expected {expectedTotalMoney}");
        }
        else
        {
            // Trường hợp giỏ hàng trống
            Console.OutputEncoding = Encoding.UTF8;
            Console.WriteLine($"{testCaseName}: Cart Emplty.");
        }
    }

    static void ClearCartAndReturnToCartPage(IWebDriver driver)
    {
        // Xóa chuỗi JSON giỏ hàng
        string clearCartScript = "localStorage.removeItem('cart'); location.reload();";
        IJavaScriptExecutor js = (IJavaScriptExecutor)driver;
        js.ExecuteScript(clearCartScript);

        // Quay trở lại trang giỏ hàng
        driver.Navigate().GoToUrl("https://localhost:44385/cart");

        // Đợi một chút để trang cập nhật
        Thread.Sleep(2000);
    }
}
