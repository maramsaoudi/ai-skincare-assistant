package com.skincare.api.service;

import com.skincare.api.dto.AiScanResponse;
import com.skincare.api.dto.ScanResponse;
import com.skincare.api.model.ScanSession;
import com.skincare.api.model.User;
import com.skincare.api.repository.ScanSessionRepository;
import com.skincare.api.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@Service
public class ScanSessionService {

    private final ScanSessionRepository scanRepository;
    private final UserRepository userRepository;
    private final AiClientService aiClientService;

    public ScanSessionService(ScanSessionRepository scanRepository,
                              UserRepository userRepository,
                              AiClientService aiClientService) {
        this.scanRepository = scanRepository;
        this.userRepository = userRepository;
        this.aiClientService = aiClientService;
    }

    public ScanResponse createScan(UUID userId, MultipartFile image) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        ScanSession scanSession = new ScanSession();
        scanSession.setUser(user);

        scanSession.setImageUrl(image.getOriginalFilename());

        AiScanResponse aiResult = aiClientService.analyzeSkin(image);

        scanSession.setAcneScore((double) aiResult.getAcne());
        scanSession.setOilinessScore((double) aiResult.getOiliness());
        scanSession.setDrynessScore((double) aiResult.getDryness());
        scanSession.setRednessScore((double) aiResult.getRedness());

        scanRepository.save(scanSession);

        return new ScanResponse(
                aiResult.getOverallScore(),
                aiResult.getAcne(),
                aiResult.getOiliness(),
                aiResult.getDryness(),
                aiResult.getRedness(),
                aiResult.getInsight()
        );
    }

    public List<ScanSession> getUserScans(UUID userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        return scanRepository.findByUser(user);
    }
}