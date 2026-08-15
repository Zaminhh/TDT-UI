```markdown
# ⚡ TDT UI Library (v2.0)

> Thư viện giao diện người dùng (UI Library) hiện đại, mượt mà và tối ưu dành cho Roblox Scripting. Được thiết kế theo phong cách tối giản với tông màu Trắng - Xám - Đen, tích hợp màn hình chào mừng hiệu ứng gõ chữ, hoạt ảnh chuyển cảnh mượt mà và hỗ trợ đầy đủ các thành phần điều khiển.

---

## 🚀 Quick Start (Chạy nhanh qua Loadstring)

Dán đoạn mã sau vào Executor của bạn để tải và khởi chạy thư viện:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaminhh/TDT-UI/main/TDTLib.lua"))()
```

---

## 📖 Hướng Dẫn Sử Dụng (API Reference)

### 1. Khởi tạo Cửa sổ chính (Window) & Màn hình chào mừng (Home Screen)

```lua
local Window = Library:CreateWindow({
    Title = "TDT Hub",
    Subtitle = "Universal Script",
    Keybind = Enum.KeyCode.LeftControl, -- Phím mở/tắt menu
    Width = 550,
    Height = 390,
    Home = {
        Title = "TDT HUB HOME",
        Subtitle = "Blox Fruits Script Hub",
        Discord = "https://discord.gg/tdt",
        Web = "https://thinhtctrackstat.com/login.php",
        Version = "TDT Hub v2.0 · discord.gg/tdt"
    }
})
```

---

### 2. Tạo Tab

```lua
local MainTab   = Window:AddTab("Main")
local PlayerTab = Window:AddTab("Player")
local VisualTab = Window:AddTab("Visual")
local SetTab    = Window:AddTab("Settings")
```

---

### 3. Tạo Section (Khối phân nhóm)

```lua
local AimSection = MainTab:AddSection("Aimbot Master")
local MoveSection = PlayerTab:AddSection("Movement")
```

---

### 4. Tạo các Thành phần Điều khiển (Elements)

#### 🔘 Button (Nút bấm)
```lua
AimSection:AddButton({
    Title = "Join Discord",
    Primary = true, -- true: Nút màu đen nổi bật | false: Nút trắng viền xám
    Callback = function()
        setclipboard("https://discord.gg/tdt")
        Library:Notify("Discord", "Đã sao chép link!", 2.5)
    end
})
```

#### 🎚 Toggle (Nút Bật / Tắt)
```lua
local myToggle = AimSection:AddToggle({
    Title = "Enable Aimbot",
    Flag = "AimbotOn", -- Tên biến lưu vào Library.Flags["AimbotOn"]
    Default = false,   -- Mặc định tắt
    Callback = function(Value)
        print("Trạng thái:", Value)
    end
})

-- Thay đổi trạng thái bằng code:
-- myToggle.Set(true)
```

#### 📊 Slider (Thanh trượt giá trị)
```lua
local mySlider = AimSection:AddSlider({
    Title = "FOV Radius",
    Flag = "AimFOV",
    Min = 30,
    Max = 600,
    Default = 160,
    Callback = function(Value)
        print("Giá trị FOV:", Value)
    end
})

-- Thay đổi giá trị bằng code:
-- mySlider.Set(200)
```

#### 🔽 Dropdown (Menu lựa chọn)
```lua
local myDropdown = AimSection:AddDropdown({
    Title = "Target Part",
    Flag = "AimPart",
    Options = { "Head", "HumanoidRootPart", "UpperTorso" },
    Default = "Head",
    Callback = function(Selected)
        print("Đã chọn:", Selected)
    end
})

-- Thay đổi hoặc làm mới danh sách:
-- myDropdown.Set("HumanoidRootPart")
-- myDropdown.Refresh({ "Head", "Torso" })
```

#### 🏷 Label (Dòng chữ hiển thị)
```lua
local myLabel = AimSection:AddLabel("Detected Entities: 0")

-- Cập nhật nội dung chữ:
-- myLabel.Set("Detected Entities: 15")
```

#### 🔔 Notification (Gửi thông báo)
```lua
Library:Notify("TDT Hub", "Script đã được tải thành công!", 3)
```

---

## 📋 Truy Xuất Giá Trị Đã Lưu (Flags)

Mọi thành phần có gắn `Flag = "..."` đều có thể lấy giá trị trực tiếp qua bảng `Library.Flags`:

```lua
task.spawn(function()
    while task.wait(0.1) do
        if Library.Flags["AimbotOn"] then
            local targetPart = Library.Flags["AimPart"]
            local fov = Library.Flags["AimFOV"]
            -- Logic xử lý tại đây
        end
    end
end)
```

---

## 🌟 Tính Năng Nổi Bật

- ✨ **Màn hình Intro:** Hiệu ứng chữ gõ máy (Typewriter) mượt mà khi vừa load script.
- 🎯 **Aimbot & Visuals:** Tương thích tốt với mọi game Roblox.
- ⚡ **Tự động quét Entity:** Quét liên tục NPC/Quái vật trong Server theo thời gian thực.
- 🛡 **Bảo vệ mã nguồn:** Tương thích 100% khi làm rối mã bằng Prometheus, Luraph hoặc IronBrew.
- ⌨️ **Hỗ trợ tùy chỉnh phím:** Dễ dàng đổi phím tắt ẩn/hiện bảng điều khiển.

---

## 👥 Credits & Support

- **Author:** Zaminhh
- **Repository:** [TDT-UI](https://github.com/Zaminhh/TDT-UI)
- **Discord:** [discord.gg/tdt](https://discord.gg/tdt)
```
