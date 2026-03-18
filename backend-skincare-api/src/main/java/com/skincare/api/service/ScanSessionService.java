package com.skincare.api.service;

import com.skincare.api.model.ScanSession;
import com.skincare.api.model.User;
import com.skincare.api.repository.ScanSessionRepository;
import com.skincare.api.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class ScanSessionService {

    private final ScanSessionRepository scanRepository;
    private final UserRepository userRepository;

    public ScanSessionService(ScanSessionRepository scanRepository,
                              UserRepository userRepository) {
        this.scanRepository = scanRepository;
        this.userRepository = userRepository;
    }

    public ScanSession createScan(UUID userId, ScanSession scanSession) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        scanSession.setUser(user);

        // 🔥 Placeholder for AI call later
        simulateAI(scanSession);

        return scanRepository.save(scanSession);
    }

    public List<ScanSession> getUserScans(UUID userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        return scanRepository.findByUser(user);
    }

    // 🔥 TEMPORARY (Day 4)
    private void simulateAI(ScanSession scan) {
        scan.setAcneScore(0.5);
        scan.setDrynessScore(0.3);
        scan.setOilinessScore(0.7);
        scan.setRednessScore(0.2);
    }
}