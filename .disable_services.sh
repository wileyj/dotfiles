#!/usr/bin/env bash
# https://gist.github.com/pwnsdx/1217727ca57de2dd2a372afdd7a0fc21

# iCloud
AGENTS+=('com.apple.icloud.fmfd' \
      	#'com.apple.cloudphotosd' \
	  	'com.apple.followupd')

# Safari useless stuff
AGENTS+=('com.apple.SafariBookmarksSyncAgent' \
		'com.apple.SafariCloudHistoryPushAgent' \
		'com.apple.WebKit.PluginAgent')

# iMessage / Facetime
AGENTS+=('com.apple.avconferenced')
#AGENTS+=('com.apple.imagent' \
#	'com.apple.imautomatichistorydeletionagent' \
#	'com.apple.imklaunchagent' \
#	'com.apple.imtransferagent')

# Game Center / Passbook / Apple TV / Homekit...
AGENTS+=('com.apple.gamed' \
		'com.apple.passd' \
		'com.apple.Maps.pushdaemon' \
		'com.apple.videosubscriptionsd' \
		'com.apple.CommCenter-osx' \
		'com.apple.homed')

# Ad-related
AGENTS+=('com.apple.ap.adprivacyd' \
		'com.apple.ap.adservicesd')

# Screensharing
AGENTS+=('com.apple.screensharing.MessagesAgent' \
		'com.apple.screensharing.agent' \
		'com.apple.screensharing.menuextra')

# Siri
AGENTS+=('com.apple.siriknowledged' \
		'com.apple.assistant_service' \
		'com.apple.assistantd' \
		'com.apple.Siri.agent' \
		'com.apple.parsec-fbf')

# VoiceOver / accessibility-related stuff
AGENTS+=('com.apple.VoiceOver' \
		'com.apple.voicememod' \
		'com.apple.accessibility.AXVisualSupportAgent' \
		'com.apple.accessibility.dfrhud' \
		'com.apple.accessibility.heard')

# Debugging process
AGENTS+=('com.apple.spindump_agent' \
		'com.apple.ReportCrash' \
		'com.apple.ReportGPURestart' \
		'com.apple.ReportPanic' \
		'com.apple.DiagnosticReportCleanup' \
		'com.apple.TrustEvaluationAgent')

# Screentime
AGENTS+=('com.apple.ScreenTimeAgent' \
		'com.apple.UsageTrackingAgent')

# Others
AGENTS+=('com.apple.parsecd' \
		'com.apple.AirPlayUIAgent' \
		'com.apple.AirPortBaseStationAgent' \
		'com.apple.familycircled' \
		'com.apple.familycontrols.useragent' \
		'com.apple.familynotificationd' \
		'com.apple.sharingd' \
		'com.apple.java.InstallOnDemand' \
		'com.apple.parentalcontrols.check' \
		'com.apple.appleseed.seedusaged' \
		'com.apple.appleseed.seedusaged.postinstall' \
		'com.apple.CallHistorySyncHelper' \
		#'com.apple.RemoteDesktop' \
		'com.apple.CallHistoryPluginHelper' \
		'com.apple.SocialPushAgent' \
		'com.apple.touristd' \
		'com.apple.macos.studentd' \
		'com.apple.KeyboardAccessAgent' \
		'com.apple.exchange.exchangesyncd' \
		'com.apple.suggestd' \
		'com.apple.helpd' \
		'com.apple.amp.mediasharingd' \
		'com.apple.remindd' \
	  'com.apple.telephonyutilities.callservicesd' \
	  'com.apple.DictationIM' \
	  'com.apple.SafariNotificationAgent')


# Daemons to disable
DAEMONS+=('com.apple.analyticsd'
	  	'com.apple.netbiosd' \
	  	'com.apple.remotepairtool' \
	  	'com.apple.security.FDERecoveryAgent' \
	  	'com.apple.SubmitDiagInfo' \
		'com.apple.screensharing' \
		'com.apple.appleseed.fbahelperd' \
		'com.apple.apsd' \
		'com.apple.ManagedClient.cloudconfigurationd' \
		'com.apple.ManagedClient.enroll' \
		'com.apple.ManagedClient' \
		'com.apple.ManagedClient.startup' \
		'com.apple.locate' \
		'com.apple.eapolcfg_auth' \
		#'com.apple.RemoteDesktop.PrivilegeProxy' \
		'com.apple.familycontrols' \
	    'com.apple.AirPlayXPCHelper' \
	    'com.apple.awdd' \
	    'com.apple.CrashReporterSupportHelper')

echo -e ":::"
echo -e "::: Disabling LaunchAgents"
echo -e ":::"
for agent in "${AGENTS[@]}"
do
    if [ -f ./System/Library/LaunchAgents/${agent}.plist ]; then
      mv ./System/Library/LaunchAgents/${agent}.plist ./System/Library/LaunchAgents/${agent}.plist.bak
      echo -e "\t|- [\033[32m+\033[m] Disabled ${agent}"
    else
      echo -e "\t|- [\033[32m+\033[m] ${agent}"
    fi
done

echo -e ":::"
echo -e "::: Disabling LaunchDaemons"
echo -e ":::"
for daemon in "${DAEMONS[@]}"
do
    if [ -f ./System/Library/LaunchDaemons/${daemon}.plist ]; then
      mv ./System/Library/LaunchDaemons/${daemon}.plist ./System/Library/LaunchDaemons/${daemon}.plist.bak
      echo -e "\t|- [\033[32m+\033[m] Disabled ${daemon}"
    else
      echo -e "\t|- [\033[32m+\033[m] ${daemon}"
    fi
done
