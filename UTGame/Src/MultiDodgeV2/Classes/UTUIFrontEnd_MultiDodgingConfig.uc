class UTUIFrontEnd_MultiDodgingConfig extends UTUIFrontEnd;

var transient UICheckBox cbMultiDodge;
var transient UICheckBox cbBoostDodging;
var transient UICheckBox cbResetMaxJump;
var transient UINumericEditBox ebMaxMultiJump;

event SceneActivated(bool bInitialActivation)
{
    super.SceneActivated(bInitialActivation);

    if (bInitialActivation)
    {
        cbMultiDodge = UICheckBox(FindChild('UICheckbox_MultiDodge', true));
        cbBoostDodging = UICheckBox(FindChild('UICheckbox_BoostDodging', true));
        cbResetMaxJump = UICheckBox(FindChild('UICheckbox_ResetMaxJump', true));
        ebMaxMultiJump = UINumericEditBox(FindChild('UINumericEditBox_MaxMultiJump', true));

        //set ui to config 
        cbMultiDodge.SetValue(class'MutMultiDodging'.default.bMultiDodge);
        cbBoostDodging.SetValue(class'MutMultiDodging'.default.bBoostDodging);
        cbResetMaxJump.SetValue(class'MutMultiDodging'.default.bResetMaxJump);
        ebMaxMultiJump.SetNumericValue(class'MutMultiDodging'.default.MaxMultiJump, true);

        ebMaxMultiJump.IncrementStyle.DefaultStyleTag='SpinnerIncrementButtonBackground';
        ebMaxMultiJump.DecrementStyle.DefaultStyleTag='SpinnerDecrementButtonBackground';
    }
}

function SetupButtonBar()
{
    ButtonBar.AppendButton("Accept", OnButtonBar_Accept);
    ButtonBar.AppendButton("Cancel", OnButtonBar_Cancel);
}

function bool OnButtonBar_Cancel(UIScreenObject InButton, int InPlayerIndex)
{
    CloseScene(self);
    return true;
}  

function bool OnButtonBar_Accept(UIScreenObject InButton, int InPlayerIndex)
{
    class'MutMultiDodging'.default.bMultiDodge = cbMultiDodge.IsChecked();
    class'MutMultiDodging'.default.bBoostDodging = cbBoostDodging.IsChecked();
    class'MutMultiDodging'.default.bResetMaxJump = cbResetMaxJump.IsChecked();
    class'MutMultiDodging'.default.MaxMultiJump = ebMaxMultiJump.NumericValue.CurrentValue;

    class'MutMultiDodging'.static.StaticSaveConfig();

    CloseScene(self);
    return true;
}  

function SetTitle()
{
	local string FinalStr;
	local UILabel TitleLabel;

	TitleLabel = GetTitleLabel();
	if ( TitleLabel != None )
	{
		if(TabControl == None)
		{
			//FinalStr = Caps(Localize("Titles", string(SceneTag), "UTGameUI"));
			FinalStr = Caps(TitleMarkupString);
			TitleLabel.SetDataStoreBinding(FinalStr);
		}
		else
		{
			TitleLabel.SetDataStoreBinding("");
		}
	}
}


defaultproperties
{
    TitleMarkupString = "Multi Dodge V2"
}