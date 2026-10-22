# 🌊 FloodAware for Garmin Connect IQ

**FloodAware** is an open-source Garmin wearable widget and Glance view that tracks real-time river discharge levels and flood risk forecasts using the **Open-Meteo Flood API** (GloFAS model). 

Part of the `*Aware` widget suite by **Australis_IQ**.

---

### ✨ Features
* **Glance View Integration:** Quick-glance status badge (`NORMAL`, `WATCH`, `HIGH`, `SEVERE`) and current discharge metric ($m^3/s$).
* **Background Sync:** Periodic background worker (`Toybox.Background`) to fetch fresh data automatically.
* **Offline Caching:** Persists the latest payload using `Application.Storage` for instant loading without network delays.
* **Companion Web Link:** Seamless transition to view expanded historical trends and details online.

### 🛠️ Tech Stack
* **Language:** Monkey C
* **API:** Open-Meteo Global Flood API (`GloFAS`)
* **Target Devices:** Garmin AMOLED & MIP smartwatches (Fenix, Forerunner, Venu, Vivoactive)

### 🚀 Companion Web Version
Visit the web companion app for full historical data and expanded metrics:  
👉 [flood.australis.iq](https://flood.australis.iq)

### 📄 License
Open-source under the MIT License.
