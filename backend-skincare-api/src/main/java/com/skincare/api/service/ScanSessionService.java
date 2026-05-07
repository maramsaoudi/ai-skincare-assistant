package com.skincare.api.service;

import com.skincare.api.dto.AiScanResponse;
import com.skincare.api.dto.ScanHistoryDto;
import com.skincare.api.dto.ScanResponse;
import com.skincare.api.model.ScanSession;
import com.skincare.api.model.User;
import com.skincare.api.repository.ScanSessionRepository;
import com.skincare.api.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
public class ScanSessionService {

    private final ScanSessionRepository scanRepository;
    private final UserRepository userRepository;
    private final AiClientService aiClientService;

    public ScanSessionService(
            ScanSessionRepository scanRepository,
            UserRepository userRepository,
            AiClientService aiClientService
    ) {
        this.scanRepository = scanRepository;
        this.userRepository = userRepository;
        this.aiClientService = aiClientService;
    }

    public ScanResponse createScan(UUID userId, MultipartFile image) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        AiScanResponse aiResult = aiClientService.analyzeSkin(image);

        LocalDateTime startOfToday = LocalDate.now().atStartOfDay();
        LocalDateTime startOfTomorrow = LocalDate.now().plusDays(1).atStartOfDay();

        boolean hasDailyScanToday =
                scanRepository.existsByUserIdAndDailyTrackerScanTrueAndCreatedAtBetween(
                        userId,
                        startOfToday,
                        startOfTomorrow
                );

        ScanSession scanSession = new ScanSession();
        scanSession.setUser(user);
        scanSession.setImageUrl(image.getOriginalFilename());

        scanSession.setAcneScore((double) aiResult.getAcne());
        scanSession.setOilinessScore((double) aiResult.getOiliness());
        scanSession.setDrynessScore((double) aiResult.getDryness());
        scanSession.setRednessScore((double) aiResult.getRedness());

        scanSession.setSkinScore((double) aiResult.getOverallScore());
        scanSession.setDailyTrackerScan(!hasDailyScanToday);

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

    public List<ScanHistoryDto> getHistory(UUID userId) {
        return scanRepository.findByUserIdOrderByCreatedAtDesc(userId)
                .stream()
                .map(scan -> new ScanHistoryDto(
                        scan.getId(),
                        scan.getSkinScore(),
                        scan.getCreatedAt()
                ))
                .toList();
    }

    public List<ScanHistoryDto> getTrackerHistory(UUID userId) {
        return scanRepository.findByUserIdAndDailyTrackerScanTrueOrderByCreatedAtDesc(userId)
                .stream()
                .map(scan -> new ScanHistoryDto(
                        scan.getId(),
                        scan.getSkinScore(),
                        scan.getCreatedAt()
                ))
                .toList();
    }
}