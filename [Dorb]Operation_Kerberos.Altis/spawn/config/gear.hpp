class gear {
    class basesoldier {
        uniform = "";
        uniformitems[] = {};
        vest = "";
        vestitems[] = {};
        backpack = "";
        backpackitems[] = {};
        primaryweapon = "";
        primaryweaponattach[] = {};
        secondaryweapon = "";
        secondaryweaponattach[] = {};
        handgun = "";
        handgunattach[] = {};
        linkeditems[] = {};
        headgear = "";
    };
    class east {
        class regular {
            class examplesoldier : basesoldier {
                uniform = "uniforname";
                uniformitems[] = {"itemtype1","itemtype1","itemtype2"};
                vest = "vestname";
                vestitems[] = {"itemtype1","itemtype1","itemtype2"};
                backpack = "backpackname";
                backpackitems[] = {"itemtype1","itemtype1","itemtype2"};
                
                primaryweapon = "machinegun";
                primaryweaponattach[] = {"bipod","muzzle","laser"};
                secondaryweapon = "launcher";
                secondaryweaponattach[] = {};
                handgun = "pistol";
                handgunattach[] = {"muzzle"};
                
                linkeditems[] = {"clock","map"};
                headgear = "helm";
            };
        };
    };
    class west {
        class regular {
        };
    };
};