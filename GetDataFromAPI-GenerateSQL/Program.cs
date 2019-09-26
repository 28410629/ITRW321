using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace GetDataFromAPI_GenerateSQL
{
    class Program
    {
        static void Main(string[] args)
        {
            
        }
        
        public static async Task<object> GetJsonAndMapToObject(string url, object jsonObject)
        {
            try
            {
                Console.WriteLine("[ OK! ] Creating HttpClient");
                using (HttpClient client = new HttpClient())
                {
                    var content = new StringContent(jsonObject.ToString(), Encoding.UTF8, "application/json");
                    Console.WriteLine("[ OK! ] Downloading JSON");
                    var response = await client.PostAsync(url, content);
                    if (response != null)
                    {
                        var jsonString = await response.Content.ReadAsStringAsync();
                        Console.WriteLine("[ OK! ] Deserialise JSON to Object");
                        return JsonConvert.DeserializeObject<object>(jsonString);
                    }
                    Console.WriteLine("[ ERR ] JSON Response Equals Null");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("[ ERR ] " + ex.Message);
            }
            return null;
        }
    }
}
