package com.sist.web.config;

import com.github.benmanes.caffeine.cache.Caffeine;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.caffeine.CaffeineCache;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.cache.support.SimpleCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;
import java.util.concurrent.TimeUnit;

@Configuration
@EnableCaching
public class CacheConfig {

	  @Bean
	    public CacheManager cacheManager() {
	        CaffeineCache accommodationCache = new CaffeineCache("accommodationCache",
	            Caffeine.newBuilder()
	                    .expireAfterWrite(10, TimeUnit.MINUTES)
	                    .maximumSize(200)
	                    .build());

	        CaffeineCache permanentCache = new CaffeineCache("permanentCache",
	            Caffeine.newBuilder()
	                    .expireAfterWrite(6, TimeUnit.HOURS)   //6시간짜리
	                    .maximumSize(100)
	                    .build());

	        SimpleCacheManager manager = new SimpleCacheManager();
	        manager.setCaches(Arrays.asList(accommodationCache, permanentCache));
	        return manager;
	    }
}