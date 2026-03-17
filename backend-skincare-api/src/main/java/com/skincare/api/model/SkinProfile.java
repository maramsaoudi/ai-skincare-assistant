package com.skincare.api.model;

import com.skincare.api.enums.SkinType;
import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "skin_profiles")
public class SkinProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Enumerated(EnumType.STRING)
    private SkinType skinType;

    private String budgetRange;

    @Column(columnDefinition = "TEXT")
    private String concerns;
}