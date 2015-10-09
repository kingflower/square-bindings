using ObjCRuntime;

[assembly: LinkWith (
	"libSocketRocket-0.4.1.a", 
	LinkTarget.Simulator | LinkTarget.Simulator64 | LinkTarget.ArmV7 | LinkTarget.ArmV7s | LinkTarget.Arm64,
	SmartLink = true, 
	ForceLoad = true,
	Frameworks = "CFNetwork Security Foundation",
	LinkerFlags = "-licucore")]
