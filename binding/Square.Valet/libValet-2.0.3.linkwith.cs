using ObjCRuntime;

[assembly: LinkWith (
	"libValet-2.0.3.a", 
	LinkTarget.Simulator | LinkTarget.Simulator64 | LinkTarget.ArmV7 | LinkTarget.ArmV7s | LinkTarget.Arm64,
	SmartLink = true, 
	ForceLoad = true,
	Frameworks = "Security")]
