package com.skincare.api.repository;

import com.skincare.api.model.ScanSession;
import com.skincare.api.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public interface ScanSessionRepository extends JpaRepository<ScanSession, UUID> {

    List<ScanSession> findByUser(User user);
    List<ScanSession> findByUserIdOrderByCreatedAtDesc(UUID userId);

    List<ScanSession> findByUserIdAndDailyTrackerScanTrueOrderByCreatedAtDesc(UUID userId);

    boolean existsByUserIdAndDailyTrackerScanTrueAndCreatedAtBetween(
            UUID userId,
            LocalDateTime start,
            LocalDateTime end
    );
}