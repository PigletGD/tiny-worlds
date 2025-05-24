class_name _GameModule
extends Resource

enum ObjectToPass {
	SET_TARGET,
	INSTIGATOR
}

# Think of this as virtual function
func invoke(args: GameModuleArgs) -> void:
	print("Game module is not implemented.")
