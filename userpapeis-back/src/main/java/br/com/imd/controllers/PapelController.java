package br.com.imd.controllers;

import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.imd.domain.Papel;
import br.com.imd.repositories.PapelRepository;

@RestController
public class PapelController {

	@RequestMapping("/papeis")
	public List<Papel> getPapeis() {
		return PapelRepository.getPapeis();
	}
	
	@GetMapping("/papeis/{papelId}")
    public Papel getPapelById(@PathVariable int papelId) {
        Papel papel = PapelRepository.getPapelById(papelId);
        return papel;
	}    
	
	@PostMapping("/papeis")
	public Papel addPapel(@RequestBody Papel papel) {
		return PapelRepository.addPapel(papel);
	}
	
	@PutMapping("/papeis/{papelId}")
	public Papel editPapel(@PathVariable int papelId, @RequestBody Papel novoPapel) {
	    Papel papelExistente = PapelRepository.getPapelById(papelId);

	    if (papelExistente != null) {
	        papelExistente.setDescricao(novoPapel.getDescricao());
	        papelExistente.setDataCadastro(novoPapel.getDataCadastro());

	        return papelExistente;
	    } else {
            throw new NoSuchElementException("Papel não encontrado com o ID: " + papelId);
	    }
	}

	
	@DeleteMapping("/papeis")
    public void deleteAllPapeis() {
		PapelRepository.deleteAll();
    }
	
	@DeleteMapping("/papeis/{papelId}")
	    public void deletePapelById(@PathVariable int papelId) {
		PapelRepository.deletePapelById(papelId);
	} 

}
