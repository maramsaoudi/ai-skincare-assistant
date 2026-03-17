package com.skincare.api.controller;

import com.skincare.api.model.SkinProfile;
import com.skincare.api.repository.SkinProfileRepository;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/skin-profiles")
public class SkinProfileController {

    private final SkinProfileRepository skinProfileRepository;

    public SkinProfileController(SkinProfileRepository skinProfileRepository) {
        this.skinProfileRepository = skinProfileRepository;
    }

    @PostMapping
    public SkinProfile createSkinProfile(@RequestBody SkinProfile profile) {
        return skinProfileRepository.save(profile);
    }

    @GetMapping("/{userId}")
    public Optional<SkinProfile> getSkinProfile(@PathVariable UUID userId) {
        return skinProfileRepository.findByUser_Id(userId);
    }
}