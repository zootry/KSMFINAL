package com.petcare.service;

import com.petcare.domain.LikesList;

public interface LikesListService {
	boolean getHasLike(String b_seq, String email); //���߿� ����
	void setLike(LikesList likesList);
	void removeLike(LikesList likesList);
}
