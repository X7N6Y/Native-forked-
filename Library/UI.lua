local UI = {}

function UI.create(Type)
    local Object = Instance.new(Type)
    for azure, Value in pairs(UI) do
        if azure ~= "create" and azure ~= "set" then
            Object[azure] = Value
        end
    end
    return Object
end

function UI.set(Property, Value)
    UI[Property] = Value
end

return UI