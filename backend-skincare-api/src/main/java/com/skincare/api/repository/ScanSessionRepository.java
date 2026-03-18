package com.skincare.api.repository;

import com.skincare.api.model.ScanSession;
import com.skincare.api.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface ScanSessionRepository extends JpaRepository<ScanSession, UUID> {

    List<ScanSession> findByUser(User user);
}