package br.com.imd.domain;

import java.util.List;
import java.util.Objects;

public class Usuario extends AbstractEntity {

	private String nome;
	private List<Papel> papeis;

	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public List<Papel> getPapeis() {
		return papeis;
	}
	public void setPapeis(List<Papel> papeis) {
		this.papeis = papeis;
	}
	@Override
	public int hashCode() {
		return Objects.hash(getId(), nome, papeis);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Usuario other = (Usuario) obj;
		return getId() == other.getId() && 
				Objects.equals(nome, other.nome) &&
				Objects.equals(papeis, other.papeis);
	}
	
	
}
