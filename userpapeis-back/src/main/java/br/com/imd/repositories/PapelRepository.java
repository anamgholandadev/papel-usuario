package br.com.imd.repositories;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import br.com.imd.domain.Papel;

public class PapelRepository {

	private static List<Papel> papeis = new ArrayList<Papel>();
    private static int proximoId = 1; 

	public static List<Papel> getPapeis(){	
		return papeis;
	}
	
    public static Papel getPapelById(int id) {
        for (Papel papel : papeis) {
            if (papel.getId() == id) {
                return papel;
            }
        }
        return null; 
    }
	
	public static Papel addPapel(Papel p) {
		p.setId(proximoId++);
		papeis.add(p);
		return p;
	}
	
	 public static boolean deletePapelById(int id) {
	        for (Papel papel : papeis) {
	            if (papel.getId() == id) {
	            	papeis.remove(papel);
	                return true; 
	            }
	        }
	        return false;
	    }
	 
	 public static boolean editPapel(int id, String novaDescricao, Date novaDataCadastro) {
		    for (Papel papel : papeis) {
		        if (papel.getId() == id) {
		            papel.setDescricao(novaDescricao);
		            papel.setDataCadastro(novaDataCadastro);
		            return true;
		        }
		    }
		    return false;
		} 
	
	public static void deleteAll() {
	    papeis.clear(); 
	}
	
}
