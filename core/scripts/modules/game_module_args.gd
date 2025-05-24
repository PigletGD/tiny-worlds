class_name GameModuleArgs
extends RefCounted

var targets: Array[Object]
var instigator: Object


func initialize(new_targets: Array[Object], new_instigator: Object) -> void:
	targets = new_targets
	instigator = new_instigator
