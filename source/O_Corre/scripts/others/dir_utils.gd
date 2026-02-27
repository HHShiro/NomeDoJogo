extends Node2D
class_name DirUtils


static func scan_folder(path: String) -> Array[String]:
	var arquivos: Array[String] = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var arquivo = dir.get_next()
		while arquivo != "":
			if not dir.current_is_dir():
				
				#Remove a extensão .remap
				if arquivo.ends_with(".remap"):
					arquivo = arquivo.trim_suffix(".remap")
				
				# 2. Remove a extensão .import 
				elif arquivo.ends_with(".import"):
					arquivo = arquivo.trim_suffix(".import")
				
				# 3. Evita duplicata
				if not arquivos.has(arquivo):
					arquivos.append(arquivo)
					
			arquivo = dir.get_next()
		
		dir.list_dir_end()
	else:
		print("Deu erro ao abrir a pasta: ", path)
		
	return arquivos
