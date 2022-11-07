package com.petcare.mapper;

import java.util.List;
import com.petcare.domain.Pet;

public interface PetMapper {	
	void signupP(Pet pet);
	List<Pet> getPetinfo(String id);
	Pet getOnePet(String petseq);
	void updateP(Pet pet);
	void deleteP(String petseq);
}