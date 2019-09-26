namespace GetDataFromAPI_GenerateSQL
{
    using System;
    using System.Collections.Generic;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class RawReadingsDto
    {
        [JsonProperty("readings")]
        public Reading[] Readings { get; set; }
    }

    public partial class Reading
    {
        [JsonProperty("date")]
        public DateTimeOffset Date { get; set; }

        [JsonProperty("air_Pressure")]
        public double AirPressure { get; set; }

        [JsonProperty("ambient_Light")]
        public long AmbientLight { get; set; }

        [JsonProperty("humidity")]
        public double Humidity { get; set; }

        [JsonProperty("temperature")]
        public double Temperature { get; set; }
    }

    public partial class RawReadingsDto
    {
        public static RawReadingsDto FromJson(string json) => JsonConvert.DeserializeObject<RawReadingsDto>(json, GetDataFromAPI_GenerateSQL.Converter.Settings);
    }

    public static class Serialize
    {
        public static string ToJson(this RawReadingsDto self) => JsonConvert.SerializeObject(self, GetDataFromAPI_GenerateSQL.Converter.Settings);
    }

    internal static class Converter
    {
        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            Converters =
            {
                new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
            },
        };
    }
}