function Component()
{
    // Default constructor
}

Component.prototype.createOperations = function()
{
    component.createOperations();

    if (systemInfo.productType === "windows") {
        component.addOperation("CreateShortcut",
                               "@TargetDir@/Catalyst.exe",
                               "@StartMenuDir@/Catalyst.lnk",
                               "workingDirectory=@TargetDir@",
                               "iconPath=%SystemRoot%/system32/SHELL32.dll",
                               "iconId=2",
                               "description=Abrir Catalyst"
        );

        component.addOperation("CreateShortcut",
                               "@TargetDir@/Catalyst.exe",
                               "@DesktopDir@/Catalyst.lnk"
        );
    }
}
