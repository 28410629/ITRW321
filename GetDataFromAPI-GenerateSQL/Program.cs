using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Net;
using System.Net.Security;
using System.Security.Authentication;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace GetDataFromAPI_GenerateSQL
{
    class Program
    {
        static void Main(string[] args)
        {
            var webRequest =
                WebRequest.Create(@"http://weatherstationapi.ddns.net:5000/api/get/rawreadings/station/day?StationId=10359964") as HttpWebRequest;
            if (webRequest == null)
            {
                return;
            }

            webRequest.ContentType = "application/json";
            webRequest.UserAgent = "Nothing";

            using (var s = webRequest.GetResponse().GetResponseStream())
            {
                using (var sr = new StreamReader(s))
                {
                    var contributorsAsJson = sr.ReadToEnd();
                    var contributors = JsonConvert.DeserializeObject<RawReadingsDto>(contributorsAsJson);
                    Console.WriteLine(contributors.Readings[0].Date);
                }
            }
        }
    }
}