package com.skincare.api.repository;

import com.skincare.api.model.SkinProfile;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface SkinProfileRepository extends JpaRepository<SkinProfile, UUID> {

    Optional<SkinProfile> findByUser_Id(UUID userId);

}