using System;
using System.IO;
using System.Net;
using Newtonsoft.Json;

namespace GetDataFromAPI_GenerateSQL
{
    class Program
    {
        static void Main(string[] args)
        {
            // Get objects
            var station0 = GetJsonObject(@"http://weatherstationapi.ddns.net:5000/api/get/rawreadings/station/day?StationId=2347795");
            var station1 = GetJsonObject(@"http://weatherstationapi.ddns.net:5000/api/get/rawreadings/station/day?StationId=10359807");
            var station2 = GetJsonObject(@"http://weatherstationapi.ddns.net:5000/api/get/rawreadings/station/day?StationId=10359964");
            
            // Get statistics on objects
            var station0Length = station0.Readings.Length;
            var station1Length = station1.Readings.Length;
            var station2Length = station2.Readings.Length;
            
            // Transform data on usable objects
            if (station0Length != 0)
            {
                Console.WriteLine("2347795: " + station0Length);
            }
            if (station1Length != 0)
            {
                Console.WriteLine("10359807: " + station1Length);
            }
            if (station2Length != 0)
            {
                Console.WriteLine("10359964: " + station2Length);
            }
        }

        static RawReadingsDto GetJsonObject(string url)
        {
            var webRequest = WebRequest.Create(url) as HttpWebRequest;
            if (webRequest == null)
            {
                return null;
            }

            webRequest.ContentType = "application/json";
            webRequest.UserAgent = "Nothing";

            using (var s = webRequest.GetResponse().GetResponseStream())
            {
                using (var sr = new StreamReader(s))
                {
                    var reponse = sr.ReadToEnd();
                    return JsonConvert.DeserializeObject<RawReadingsDto>(reponse);
                }
            }
        }
    }
}