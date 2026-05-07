package com.skincare.api.controller;

import com.skincare.api.dto.ScanHistoryDto;
import com.skincare.api.dto.ScanResponse;
import com.skincare.api.service.ScanSessionService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/scans")
public class ScanSessionController {

    private final ScanSessionService scanService;


    public ScanSessionController(ScanSessionService scanService) {
        this.scanService = scanService;
    }

    // POST /scans?userId=...
    @PostMapping
    public ScanResponse createScan(
            @RequestParam UUID userId,
            @RequestParam("image") MultipartFile image
    ) {
        return scanService.createScan(userId, image);
    }

    // GET /scans/{userId}
    @GetMapping("/{userId}")
    public List<ScanHistoryDto> getUserScans(@PathVariable UUID userId) {
        return scanService.getHistory(userId);
    }

    @GetMapping("/tracker/{userId}")
    public List<ScanHistoryDto> getTrackerHistory(@PathVariable UUID userId) {
        return scanService.getTrackerHistory(userId);
    }
}