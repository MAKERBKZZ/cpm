gg.clearResults()
gg.clearList()
gg.setVisible(false)
gg.sleep(100)
gg.toast("█                                           10% ")
gg.sleep(100)
gg.toast("███                                     20% ")
gg.sleep(100)
gg.toast("█████                              30% ")
gg.sleep(100)
gg.toast("███████                       40% ")
gg.sleep(100)
gg.toast("████████                   60% ")
gg.sleep(100)
gg.toast("█████████                 65% ")
gg.sleep(100)
gg.toast("███████████          80% ")
gg.sleep(100)
gg.toast("████████████     85% ")
gg.sleep(100)
gg.toast("████████████     90% ")
gg.sleep(100)
gg.toast("█████████████100%")
print("☠️ || ADELA STORE☠")

PW = gg.prompt({
  "🔒🗝️:INPUT PASSWORD:🗝️🔒•[⬇️]• "
}, {
  [1] = ""
}, {
  [1] = "text"
})

if not PW then
    return
end

if PW[1] == "" then
    gg.alert("Game : CPM\nScript : Dellstore.ID\nVersion : {BETA}\nClass : VIP")
    gg.alert("☠️VVIP CHEAT ACE RACER  || ADELA STORE☠")
    os.exit()
end

if PW[1] == "VIP" then
    local choice = gg.alert([[
WELCOME TO CHEAT CPM 
RELOG AFTER INJECT]], "〘 NO 〙", "〘 YES 〙")
    if choice == 1 then
        os.exit()
    end
else
    gg.alert("🔐❌Wrong password❌🔐 Try Again!")
    return
end

-- L1500 util functions

local function isProcess64bit()
    local regions = gg.getRangesList()
    local lastAddress = regions[#regions]["end"]
    return (lastAddress >> 32) ~= 0
end

local function get_classNamePtr_from_className(first_letter)
    local regionsToSearch = {
        gg.REGION_C_ALLOC,
        gg.REGION_OTHER,
        gg.REGION_ANONYMOUS
    }
    
    local classNamePtr = {}
    for _, region in ipairs(regionsToSearch) do
        gg.setRanges(region)
        gg.searchNumber(first_letter, gg.TYPE_BYTE)
        gg.refineNumber(first_letter, gg.TYPE_BYTE)
        classNamePtr = gg.getResults(gg.getResultsCount())
        gg.clearResults()
        if #classNamePtr > 0 then
            break
        end
    end
    if #classNamePtr == 0 then
        print("class not found")
        return nil
    end
    return classNamePtr
end

-- main code
local x64 = isProcess64bit()
local pointerType = x64 and gg.TYPE_QWORD or gg.TYPE_DWORD

local menuOptions = {
    "Free Body Item Price (Money)",
    "SUNTIK MONEY VIA BUSINESS",
    "SUNTIK COIN",
    "EXIT"
}

local classes_and_fields = {
    ["Free Body Item Price (Money)"] = {
        class = "bodyItem",
        fields = {
            price = {gg.TYPE_DWORD, 0x28, 0}
        }
    },
    ["SUNTIK MONEY VIA BUSINESS"] = {
        class = "ProfitControl",
        fields = {
            MoneyHas = {gg.TYPE_QWORD, 0x24, 999280422945287350}
        }
    },
    ["SUNTIK COIN"] = function()
        gg.clearResults()
        gg.clearList()
        gg.setRanges(gg.REGION_CODE_APP)
        gg.searchNumber("-1.28235374E34;-2.87512967E-14;-8.20042309E-25:9", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
        gg.refineNumber("-1.28235374E34;-2.87512967E-14", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
        revert = gg.getResults(850, nil, nil, nil, nil, nil, nil, nil, nil)
        gg.editAll("-3.43605772E11;-6.13017998E13", gg.TYPE_FLOAT)
        gg.processResume()
        gg.clearResults()
        gg.clearList()
        gg.toast("✅𝐃𝐎𝐍𝐄✅")
        gg.alert("Beli Peralatan/ emot/ mobil coin agar coin berkurang 500-1000  lalu lakukan restart game | Dellstorecpm.id")
        gg.processResume()
    end,
    ["EXIT"] = nil
}

while true do
    gg.setVisible(false)
    local menu = gg.choice(menuOptions, nil, "☠️ VVIP CHEAT CAR PARKING MULTIPLAYER  || DELLSTORECPM.ID ☠️")

    if menu == nil then
        return
    elseif menu == #menuOptions then
        gg.alert("☠️ VVIP CHEAT CAR PARKING MULTIPLAYER  || DELLSTORECPM.ID ☠️")
        os.exit()
    end

    local chosenOption = menuOptions[menu]
    local chosenData = classes_and_fields[chosenOption]

    if chosenData == nil then
        gg.alert("Invalid option selected!")
    else
        gg.toast("✅ Modifying " .. chosenOption .. " ✅")

        if type(chosenData) == "function" then
            chosenData()
        else
            local chosenClass = chosenData.class
            local fields_list = chosenData.fields

            gg.setRanges(gg.REGION_OTHER)
            local metadata = gg.getRangesList("global-metadata.dat")

            local region_start, region_end
            if metadata == nil then
                region_start = metadata[1]["start"] and gg.TYPE_QWORD or gg.TYPE_DWORD
                region_end = metadata[1]["end"]
            else
                region_start = 0
                region_end = -1
            end

            gg.searchNumber(":" .. string.char(0) .. chosenClass .. string.char(0), gg.TYPE_BYTE, false, gg.SIGN_EQUAL, region_start, region_end, 1)
            local letters = gg.getResults(2)
            local class_first_letter = {letters[2]}

            gg.clearResults()
            gg.loadResults(class_first_letter)
            gg.searchPointer(0)
            local class_name_pointer = get_classNamePtr_from_className(class_first_letter)

            if class_name_pointer == nil then
                gg.alert("Failed to find the class!")
            else
                gg.setRanges(gg.REGION_ANONYMOUS)
                local class_instances = {}

                for _, class_ptr in ipairs(class_name_pointer) do
                    local class_pointer = {
                        {
                            address = class_ptr.address - (x64 and 0x10 or 0x8),
                            flags = pointerType
                        }
                    }
                    class_pointer = gg.getValues(class_pointer)
                    class_pointer[1].name = 'class_pointer'

                    gg.clearResults()
                    gg.loadResults(class_pointer)
                    gg.searchPointer(0)
                    class_instances = gg.getResults(10000)
                    if #class_instances > 0 then
                        break
                    end
                end

                if #class_instances == 0 then
                    print("class not found")
                else
                    for _, instance in ipairs(class_instances) do
                        instance.name = chosenClass
                    end
                    gg.addListItems(class_instances)

                    for field, params in pairs(fields_list) do
                        local instances_parameters = {}
                        for _, instance in ipairs(class_instances) do
                            table.insert(instances_parameters, {
                                address = instance.address + params[2],
                                flags = params[1]
                            })
                        end
                        instances_parameters = gg.getValues(instances_parameters)

                        for _, instance_param in ipairs(instances_parameters) do
                            instance_param.name = field
                        end
                        gg.addListItems(instances_parameters)

                        if #params == 3 then
                            for _, instance_param in ipairs(instances_parameters) do
                                instance_param.value = params[3]
                            end
                            gg.setValues(instances_parameters)
                        end
                    end

                    print('Finished')
                    gg.removeListItems(class_instances)
                end
            end
        end
    end
end
