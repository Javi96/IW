package es.ucm.fdi.iw.model;

public class Gallery {

	private String name;
	private Integer item;
	
	public Gallery(String name, Integer item) {
		this.name=name;
		this.item=item;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getItem() {
		return item;
	}

	public void setItem(Integer item) {
		this.item = item;
	}
}
