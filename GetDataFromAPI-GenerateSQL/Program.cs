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
            Console.WriteLine("[ OK! ] Getting json for station 2347795");
            var station0 = GetJsonObject(@"http://weatherstationapi.ddns.net:5000/api/get/rawreadings/station/day?StationId=2347795");
            Console.WriteLine("[ OK! ] Getting json for station 2347795");
            var station1 = GetJsonObject(@"http://weatherstationapi.ddns.net:5000/api/get/rawreadings/station/day?StationId=10359807");
            Console.WriteLine("[ OK! ] Getting json for station 2347795");
            var station2 = GetJsonObject(@"http://weatherstationapi.ddns.net:5000/api/get/rawreadings/station/day?StationId=10359964");
            
            // Get statistics on objects
            var station0Length = station0.Readings.Length;
            var station1Length = station1.Readings.Length;
            var station2Length = station2.Readings.Length;
            
            // Transform data on usable objects
            if (station0Length != 0)
            {
                Console.WriteLine("[ OK! ] Starting to transform station 2347795");
                GenerateInserSql(station0);
            }
            if (station1Length != 0)
            {
                Console.WriteLine("[ OK! ] Starting to transform station 10359807");
                GenerateInserSql(station1);
            }
            if (station2Length != 0)
            {
                Console.WriteLine("[ OK! ] Starting to transform station 10359964");
                GenerateInserSql(station2);
            }
        }

        static RawReadingsDto GetJsonObject(string url)
        {
            try
            {
                Console.WriteLine("[ OK! ] Creating HttpWebRequest");
                var webRequest = WebRequest.Create(url) as HttpWebRequest;
                if (webRequest == null)
                {
                    Console.WriteLine("[ ERR ] HttpWebRequest return null");
                    return null;
                }

                webRequest.ContentType = "application/json";
                webRequest.UserAgent = "Nothing";

                using (var s = webRequest.GetResponse().GetResponseStream())
                {
                    using (var sr = new StreamReader(s))
                    {
                        Console.WriteLine("[ OK! ] Creating object from json");
                        var reponse = sr.ReadToEnd();
                        return JsonConvert.DeserializeObject<RawReadingsDto>(reponse);
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("[ ERR ] " + e.Message);
            }
            
        }

        static Void GenerateInserSql(RawReadingsDto json)
        {
            
        }
    }
}