# WindowsPooGoneNow

## Windows SSD Poo-Flusher (Maintenance Script)

A lightweight, automated batch script designed for high-RAM Windows systems (16GB to 64GB+) to reclaim massive amounts of wasted SSD space. 

## 💩 The Problem
Windows is "greedy." If you have 64GB of RAM, Windows often reserves up to **27GB or more** of your SSD for a hibernation file (`hiberfil.sys`) that you probably never use. Add in Windows Update logs, temp files, and prefetch bloat, and you're losing nearly 40GB of storage to digital "poo."

## ✨ The Solution
This script acts as a "digital toilet flush" for your C: drive. It dynamically detects your hardware and clears out the junk that standard disk cleanup tools often miss.

### What it actually does:
1.  **Detects RAM:** Automatically identifies if you are on a 16GB, 32GB, or 64GB system.
2.  **Flushes Hibernation:** Kills the massive `hiberfil.sys` file instantly.
3.  **Cleans Update Cache:** Wipes the `SoftwareDistribution` folder where old Windows Updates go to die.
4.  **Wipes Temp Folders:** Clears both User and System-wide temporary files.
5.  **Clears Prefetch:** Resets the application launch cache to remove stale entries.
6.  **Empties Recycle Bin:** A final purge of the system-wide trash.
7.  **Calculates Gains:** Tells you exactly how much "Poo" was flushed in MB or GB.

---

## 🚀 How to Use

1. **Download** the `WindowsPooGoneNow.bat` file from this repo.
2. **Right-click** the file and select **"Run as Administrator"** (This is required to touch system files).
3. **Witness the Glory:** Watch the "Total Poo flushed" counter and enjoy your reclaimed space.

---

## 🛠️ The Code (Quick Preview)
The script utilizes a mix of Batch and PowerShell to ensure accuracy:

```batch
:: Example of the dynamic space calculation used in the script
for /f "tokens=*" %%a in ('powershell -command "$diff = %space_after% - %space_before%; if ($diff -lt 1) { [math]::Round($diff * 1024, 2).ToString() + ' MB' } else { [math]::Round($diff, 2).ToString() + ' GB' }"') do set total_freed=%%a
⚠️ Disclaimer
Fast Startup: Disabling Hibernation also disables Windows "Fast Startup." On modern SSDs, the difference is negligible (seconds), but it is a trade-off.

Prefetch: Your apps might take 2 seconds longer to open the very first time after a flush as Windows rebuilds the cache.
```
---

## 🔒 The Hashes

MD5 hash: fb334dfd63b7ff236fed7d2cf4044f86

SHA1 hash: a28a16330b2b83269ec8d85bda461ed7fb5217ac

SHA256 hash: 4ec942da52dafba02a2b47c8fd4cb35715b0262b13f94c940b56e7285a33fa86

SHA512 hash: ebff194960d2fe75928bd7084d593dcc9efa29e499dde311c5c5ce85ee9b09598004bc6769ac1a8e575da913753c24f6ff6786ddb9b64eb08f261ae19f75aaa1

