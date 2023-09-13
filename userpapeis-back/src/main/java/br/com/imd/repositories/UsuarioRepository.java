package br.com.imd.repositories;

import java.util.ArrayList;
import java.util.List;

import br.com.imd.domain.Usuario;

public class UsuarioRepository {

	public static List<Usuario> usuarios = new ArrayList<Usuario>();
    private static int proximoId = 1; 

	
	public static List<Usuario> getUsuarios() {
		return usuarios;
	}
	
	public static Usuario getUsuarioById(int id) {
        for (Usuario usuario : usuarios) {
            if (usuario.getId() == id) {
                return usuario;
            }
        }
        return null;
    }
	
	public static Usuario addUsuario(Usuario usuario) {
        usuario.setId(proximoId++);
        usuarios.add(usuario);
        return usuario;
    }
	
	public static Usuario editUsuario(int id, Usuario novoUsuario) {
	    for (Usuario usuario : usuarios) {
	        if (usuario.getId() == id) {
	            usuario.setNome(novoUsuario.getNome());
	            usuario.setPapeis(novoUsuario.getPapeis());
	            usuario.setDataCadastro(novoUsuario.getDataCadastro());
	            return usuario;
	        }
	    }
	    return null;
	}

	
	 public static boolean deleteUsuarioById(int id) {
	        for (Usuario usuario : usuarios) {
	            if (usuario.getId() == id) {
	                usuarios.remove(usuario);
	                return true; 
	            }
	        }
	        return false;
	}
	 
	public static void deleteAllUsuarios() {
	        usuarios.clear();
	}
}
