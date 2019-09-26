using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using Newtonsoft.Json;

namespace GetDataFromAPI_GenerateSQL
{
    class Program
    {
        private static List<String> lines;
        
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
            lines = new List<string>();
            if (station0Length != 0)
            {
                Console.WriteLine("[ OK! ] Starting to transform station 2347795");
                GenerateInsertSql(station0, 1, 1);
            }
            if (station1Length != 0)
            {
                Console.WriteLine("[ OK! ] Starting to transform station 10359807");
                GenerateInsertSql(station1, 2, 1);
            }
            if (station2Length != 0)
            {
                Console.WriteLine("[ OK! ] Starting to transform station 10359964");
                GenerateInsertSql(station2, 3, 2);
            }
            
            // Write sql file to load new data into db
            WriteSqlFile();
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

                Console.WriteLine("[ OK! ] Downloading json");
                using (var s = webRequest.GetResponse().GetResponseStream())
                {
                    using (var sr = new StreamReader(s))
                    {
                        Console.WriteLine("[ OK! ] Creating object from json");
                        var reponse = sr.ReadToEnd();
                        if (reponse != "")
                        {
                            return JsonConvert.DeserializeObject<RawReadingsDto>(reponse);
                        }
                        else
                        {
                            Console.WriteLine("[ ERR ] Body of json was empty can't create object");
                            return new RawReadingsDto();
                        }
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("[ ERR ] " + e.Message);
                return new RawReadingsDto();
            }
        }

        static void GenerateInsertSql(RawReadingsDto json, int stationid, int location)
        {
            try
            {
                for (int i = 0; i < json.Readings.Length; i++)
                {
                    lines.Add(
                        "INSERT INTO \"STATIONREADING\" (STATIONID, READINGLOCATION, READING_DATE, TEMPERATURE, AIR_PRESSURE, AMBIENT_LIGHT, HUMIDITY, ALTITUDE) VALUES ("
                        + stationid + ", "
                        + location + ", TO_DATE(\'" +
                        + json.Readings[i].Date.Year + "-"
                        + json.Readings[i].Date.Month + "-"
                        + json.Readings[i].Date.Day + " "
                        + json.Readings[i].Date.Hour + ":"
                        + json.Readings[i].Date.Minute + ":"
                        + json.Readings[i].Date.Second + "\', \'YYYY-MM-DD HH24:MI:SS\'), "
                        + json.Readings[i].Temperature + ", "
                        + json.Readings[i].AirPressure + ", "
                        + json.Readings[i].AmbientLight / 10.24 + ", "
                        + json.Readings[i].Humidity + ", "
                        + 1335 + ");");
                }
                File.WriteAllLines(@"C:\Users\Public\TestFolder\WriteLines.txt" + DateTime.Now.Date.Year, lines);
            }
            catch (Exception e)
            {
                Console.WriteLine("[ ERR ] " + e.Message);
            }
        }

        static void WriteSqlFile()
        {
            try
            {
                Console.WriteLine("[ OK! ] Starting writing sql file, lines amount to " + lines.Count);
                String path = Directory.GetCurrentDirectory() + "/" +
                              + DateTime.Now.Date.Year + "-"
                              + DateTime.Now.Date.Month + "-"
                              + DateTime.Now.Date.Day + "_"
                              + DateTime.Now.Hour + ""
                              + DateTime.Now.Minute
                              + ".sql";
                
                File.WriteAllLines(path, lines);
                Console.WriteLine("[ OK! ] Done writing file: " + path);
            }
            catch (Exception e)
            {
                Console.WriteLine("[ ERR ] " + e.Message);
            }
        }
    }
}