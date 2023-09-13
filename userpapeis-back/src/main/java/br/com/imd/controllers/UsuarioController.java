package br.com.imd.controllers;

import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.imd.domain.Papel;
import br.com.imd.domain.Usuario;
import br.com.imd.repositories.PapelRepository;
import br.com.imd.repositories.UsuarioRepository;

@RestController
public class UsuarioController {
	
	@RequestMapping("/usuarios")
	public List<Usuario> getUsuarios() {
		return UsuarioRepository.getUsuarios();
	}
	
	@GetMapping("/usuarios/{usuarioId}")
    public Usuario getUsuarioById(@PathVariable int usuarioId) {
		Usuario usuario = UsuarioRepository.getUsuarioById(usuarioId);
        return usuario;
	}    
	
	@PostMapping("/usuarios")
	public Usuario addUsuario(@RequestBody Usuario usuario) {
		return UsuarioRepository.addUsuario(usuario);
	}
	
	@DeleteMapping("/usuarios")
    public void deleteAllUsuarios() {
		UsuarioRepository.deleteAllUsuarios();
    }

	@PutMapping("/usuarios/{usuarioId}")
	public Usuario editUsuario(@PathVariable int usuarioId, @RequestBody Usuario novoUsuario) {
		Usuario usuarioExistente = UsuarioRepository.getUsuarioById(usuarioId);

	    if (usuarioExistente != null) {
	    	usuarioExistente.setNome(novoUsuario.getNome());
	    	usuarioExistente.setDataCadastro(novoUsuario.getDataCadastro());
	    	usuarioExistente.setPapeis(novoUsuario.getPapeis());
	        return usuarioExistente;
	    } else {
            throw new NoSuchElementException("Usuário não encontrado com o ID: " + usuarioId);
	    }
	}
	
	@DeleteMapping("/usuarios/{usuarioId}")
	    public void deleteUsuarioById(@PathVariable int usuarioId) {
		UsuarioRepository.deleteUsuarioById(usuarioId);
	} 

}
