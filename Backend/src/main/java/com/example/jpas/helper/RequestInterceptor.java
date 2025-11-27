package com.example.jpas.helper;

import com.example.jpas.service.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
@RequiredArgsConstructor
public class RequestInterceptor implements HandlerInterceptor {

    private final JwtUtil jwtUtil;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        String authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Missing or invalid Authorization header");
            return false;
        }

        try {
            String token = authHeader.substring(7); // Remove "Bearer " prefix

            // Validate JWT token
            jwtUtil.validateToken(token);

            // Optionally, you can add user info to request attributes
            String userEmail = jwtUtil.getUserEmailFromToken(token);
            request.setAttribute("userEmail", userEmail);
            request.setAttribute("userId", jwtUtil.getUserIdFromToken(token));
            request.setAttribute("userRole", jwtUtil.getUserRoleFromToken(token));

            return true;
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Invalid or expired JWT token");
            return false;
        }
    }
}
