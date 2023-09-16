/// <summary>
/// 获取到本地的Json文件并且解析返回对应的json字符串
/// </summary>
/// <param name="filepath">文件路径</param>
/// <returns></returns>
string GetJsonFile(string filepath)
{
    string json = string.Empty;
    using (FileStream fs = new FileStream(filepath, FileMode.OpenOrCreate, System.IO.FileAccess.ReadWrite, FileShare.ReadWrite))
    {
        using (StreamReader sr = new StreamReader(fs, Encoding.UTF8))
        {
            json = sr.ReadToEnd().ToString();
        }
    }
    return json;
}

GetJsonFile(@"D:\note\locc.json")