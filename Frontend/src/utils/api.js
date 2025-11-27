import axios from "axios";

const api = axios.create({
  baseURL: "http://localhost:8090/api",
});

api.interceptors.request.use((config) => {
  const isAuthRequest =
    config.url?.includes("auth/admin/google") ||
    config.url?.includes("auth/google");

  if (!isAuthRequest) {
    const user = JSON.parse(localStorage.getItem("user"));
    if (user?.token) {
      config.headers = config.headers || {};
      config.headers.Authorization = `Bearer ${user.token}`;
    }
  }
  return config;
});

export const fetchDomains = () => 
    api.get("v1/domain");

export const fetchCourseByDomain = (domainId) =>
  api.get(`v1/byDomain/${domainId}`);

export const fetchStudents = (courseId) =>
  api.get(`courses/${courseId}/students`);

export const loginWithGoogle = (credential) =>
  api.post("/v1/auth/admin/google", { credential });
