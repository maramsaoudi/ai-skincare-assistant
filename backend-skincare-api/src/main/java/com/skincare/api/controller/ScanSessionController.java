package com.skincare.api.controller;

import com.skincare.api.model.ScanSession;
import com.skincare.api.service.ScanSessionService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/scans")
public class ScanSessionController {

    private final ScanSessionService scanService;

    public ScanSessionController(ScanSessionService scanService) {
        this.scanService = scanService;
    }

    // ✅ POST /scans?userId=
    @PostMapping
    public ScanSession createScan(
            @RequestParam UUID userId,
            @RequestBody ScanSession scanSession) {

        return scanService.createScan(userId, scanSession);
    }

    // ✅ GET /scans/{userId}
    @GetMapping("/{userId}")
    public List<ScanSession> getUserScans(@PathVariable UUID userId) {
        return scanService.getUserScans(userId);
    }
}