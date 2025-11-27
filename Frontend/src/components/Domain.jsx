import React, { useState, useEffect, useContext } from "react";
import { Link, useNavigate, useLocation } from "react-router-dom";
import "../Styles/domain.css";
import { fetchDomains, fetchCourseByDomain } from "../utils/api";
import { UserContext } from "../UserContext";

const DomainList = () => {
  const [domains, setDomains] = useState([]);
  const [selectedDomain, setSelectedDomain] = useState();
  const [selectedDomainName, setSelectedDomainName] = useState("");
  const [courses, setCourses] = useState([]);
  const { user, setUser } = useContext(UserContext);
  const navigate = useNavigate();
  const location = useLocation();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [selectedDay, setSelectedDay] = useState("Monday");
  const [showSuccess, setShowSuccess] = useState(false);
  const [isHelpDeskOpen, setIsHelpDeskOpen] = useState(false);

  const handleComplaintSubmit = (e) => {
    e.preventDefault();
    // Simulate API call
    setTimeout(() => {
      setShowSuccess(true);
    }, 500);
  };

  // ... existing code ...

  {/* Help Desk Section - Collapsible */ }
  <div className="help-desk-section-final">
    {!isHelpDeskOpen ? (
      <div className="help-desk-trigger-container-final">
        <p className="help-text-trigger-final" onClick={() => setIsHelpDeskOpen(true)}>
          Having trouble? <span className="link-text-final">Contact Help Desk (v4)</span>
        </p>
      </div>
    ) : (
      <div className="help-card-final">
        <div className="help-card-header-final">
          <h3><i className="fas fa-headset"></i> Help & Support</h3>
          <button
            className="close-help-btn-final"
            onClick={() => setIsHelpDeskOpen(false)}
          >
            <i className="fas fa-times"></i>
          </button>
        </div>

        <div className="contact-info">
          <p>Need assistance? Contact our Help Desk:</p>
          <div className="phone-number">
            <i className="fas fa-phone-alt"></i> +91-98765-43210
          </div>
        </div>

        <div className="complaint-box">
          <h4>Lodge a Complaint</h4>
          {!showSuccess ? (
            <form onSubmit={handleComplaintSubmit} className="complaint-form">
              <input
                type="text"
                placeholder="Subject"
                className="complaint-input"
                required
              />
              <textarea
                placeholder="Describe your issue..."
                className="complaint-textarea"
                rows="3"
                required
              ></textarea>
              <button type="submit" className="submit-complaint-btn">
                Submit Report
              </button>
            </form>
          ) : (
            <div className="success-message">
              <i className="fas fa-check-circle"></i>
              <p>Thanks for report</p>
              <button onClick={() => setShowSuccess(false)} className="reset-btn">Send another</button>
            </div>
          )}
        </div>
      </div>
    )}
  </div>

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetchDomains();
        setDomains(response.data);
      } catch (error) {
        console.error("Error fetching domains:", error);
      }
    };
    fetchData();
  }, []);

  // Restore state if returning from StudentList
  useEffect(() => {
    if (location.state && location.state.domainId && location.state.domainName) {
      const { domainId, domainName } = location.state;
      setSelectedDomain(domainId);
      setSelectedDomainName(domainName);

      // Clear state so refresh doesn't trigger it again
      window.history.replaceState({}, '');

      // Fetch courses for the restored domain
      const loadCourses = async () => {
        setLoading(true);
        try {
          const response = await fetchCourseByDomain(domainId);
          setCourses(response.data);
        } catch (err) {
          console.error("Error fetching courses:", err);
          setError("Failed to load courses.");
        } finally {
          setLoading(false);
        }
      };
      loadCourses();
    }
  }, [location.state]);

  const handleDomainSelection = async (program, batch) => {
    setError(null);
    const domain = domains.find(
      (d) => d.program === program && d.batch === batch
    );

    if (!domain) {
      setError("Domain not found");
      return;
    }

    setSelectedDomain(domain.id);
    setSelectedDomainName(program);
    setLoading(true);

    try {
      const response = await fetchCourseByDomain(domain.id);
      setCourses(response.data);
      setSelectedDay("Monday"); // Reset to Monday when new domain selected
    } catch (err) {
      console.error("Error fetching courses:", err);
      setError("Failed to load courses. Please try logging in again.");
      if (err.response && err.response.status === 401) {
        // Token might be expired
        handleLogout();
      }
    } finally {
      setLoading(false);
    }
  };

  const handleLogout = () => {
    // Clear user data from context and localStorage
    setUser(null);
    localStorage.removeItem("user");
    navigate("/");
  };

  // Get unique branches from domains
  const imtechBranches = domains
    .filter((d) => d.program.includes("iMTech"))
    .map((d) => d.program.replace("iMTech ", ""));

  const mtechBranches = domains
    .filter((d) => d.program.includes("MTech") && !d.program.includes("iMTech"))
    .map((d) => d.program.replace("MTech ", ""));

  // Filter courses by selected day
  const coursesForDay = courses.filter(
    (course) => course.schedule && course.schedule.day === selectedDay
  );

  const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

  return (
    <div>
      {/* Header with user info and logout */}
      <div className="app-header">
        <h1>ACADEMIC ERP</h1>
        <div className="user-info">
          <span className="user-name">Welcome, {user?.name || "User"}</span>
          <button className="logout-btn" onClick={handleLogout}>
            Logout
          </button>
        </div>
      </div>

      {/* Domain Selection - Dropdown Layout */}
      {!selectedDomain && (
        <div className="selection-container-centered">
          <div className="domain-selection-card">
            <h2>Select Domain to View Schedule</h2>

            <div className="dropdown-container">
              <select
                className="domain-dropdown"
                onChange={(e) => {
                  const [program, batch] = e.target.value.split('|');
                  if (program && batch) {
                    handleDomainSelection(program, batch);
                  }
                }}
                defaultValue=""
              >
                <option value="" disabled>Select a domain...</option>
                <optgroup label="Integrated M.Tech">
                  {[...new Set(imtechBranches)].map((branch) => (
                    <option key={`imtech-${branch}`} value={`iMTech ${branch}|2025`}>
                      iMTech {branch}
                    </option>
                  ))}
                </optgroup>
                <optgroup label="M.Tech">
                  {[...new Set(mtechBranches)].map((branch) => (
                    <option key={`mtech-${branch}`} value={`MTech ${branch}|2025`}>
                      M.Tech {branch}
                    </option>
                  ))}
                </optgroup>
              </select>
            </div>

            <p className="selection-placeholder">
              [ Please select a domain to load the timetable... ]
            </p>
          </div>

          {/* Help Desk Section - Kept at bottom */}
          <div className="help-desk-section-final">
            {!isHelpDeskOpen ? (
              <div className="help-desk-trigger-container-final">
                <p className="help-text-trigger-final" onClick={() => setIsHelpDeskOpen(true)}>
                  Having trouble? <span className="link-text-final">Contact Help Desk</span>
                </p>
              </div>
            ) : (
              <div className="help-card-final">
                <div className="help-card-header-final">
                  <h3><i className="fas fa-headset"></i> Help & Support</h3>
                  <button
                    className="close-help-btn-final"
                    onClick={() => setIsHelpDeskOpen(false)}
                  >
                    <i className="fas fa-times"></i>
                  </button>
                </div>

                <div className="contact-info">
                  <p>Need assistance? Contact our Help Desk:</p>
                  <div className="phone-number">
                    <i className="fas fa-phone-alt"></i> +91-98765-43210
                  </div>
                </div>

                <div className="complaint-box">
                  <h4>Lodge a Complaint</h4>
                  {!showSuccess ? (
                    <form onSubmit={handleComplaintSubmit} className="complaint-form">
                      <input
                        type="text"
                        placeholder="Subject"
                        className="complaint-input"
                        required
                      />
                      <textarea
                        placeholder="Describe your issue..."
                        className="complaint-textarea"
                        rows="3"
                        required
                      ></textarea>
                      <button type="submit" className="submit-complaint-btn">
                        Submit Report
                      </button>
                    </form>
                  ) : (
                    <div className="success-message">
                      <i className="fas fa-check-circle"></i>
                      <p>Thanks for report</p>
                      <button onClick={() => setShowSuccess(false)} className="reset-btn">Send another</button>
                    </div>
                  )}
                </div>
              </div>
            )}
          </div>
        </div>
      )}

      {error && <div className="error-message">{error}</div>}

      {loading && <div className="loading-message">Loading timetable...</div>}

      {!loading && !error && selectedDomain && (
        <div className="timetable-section">
          {/* Sticky Navigation Container */}
          <div className="timetable-nav-sticky">
            <div className="timetable-header">
              <h2>{selectedDomainName} - COURSE TIMETABLE</h2>
              <button className="back-to-domains-btn" onClick={() => setSelectedDomain(null)}>
                ← Back to Domains
              </button>
            </div>

            {/* Day Tabs */}
            <div className="day-tabs">
              {days.map((day) => (
                <button
                  key={day}
                  className={`day-tab ${selectedDay === day ? "active" : ""}`}
                  onClick={() => setSelectedDay(day)}
                >
                  {day}
                </button>
              ))}
            </div>
          </div>

          {/* Courses for Selected Day */}
          <div className="day-courses">
            {coursesForDay.length === 0 ? (
              <div className="no-courses">
                <div className="empty-state-icon">
                  <i className="fas fa-calendar-day"></i>
                </div>
                <h3>No classes scheduled for {selectedDay}</h3>
                <p>Enjoy your free time!</p>
              </div>
            ) : (
              <div className="timetable-table-container">
                <table className="timetable-data-table">
                  <thead>
                    <tr>
                      <th className="col-time">Time</th>
                      <th className="col-code">Code</th>
                      <th className="col-course">Course Name</th>
                      <th className="col-faculty">Faculty</th>
                      <th className="col-room">Room</th>
                      <th className="col-credits">Credits</th>
                      <th className="col-action">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    {coursesForDay.sort((a, b) => a.schedule.time.localeCompare(b.schedule.time)).map((course) => (
                      <tr key={course.id}>
                        <td className="col-time">
                          <div className="time-badge">
                            <i className="far fa-clock"></i>
                            {course.schedule.time}
                          </div>
                        </td>
                        <td className="col-code">
                          <span className="code-pill">{course.c_code}</span>
                        </td>
                        <td className="col-course">
                          <span className="course-name-text">{course.name}</span>
                        </td>
                        <td className="col-faculty">
                          <div className="faculty-info">
                            <div className="faculty-avatar-placeholder">
                              {course.faculty?.f_name ? course.faculty.f_name.charAt(0) : "T"}
                            </div>
                            <span>{course.faculty?.f_name || "TBA"}</span>
                          </div>
                        </td>
                        <td className="col-room">
                          <span className="room-text">{course.schedule.room}</span>
                        </td>
                        <td className="col-credits">
                          <span className="credits-text">{course.credit}</span>
                        </td>
                        <td className="col-action">
                          <Link
                            to={`/courses/${course.id}/students`}
                            state={{
                              previousDomainId: selectedDomain,
                              previousDomainName: selectedDomainName
                            }}
                            className="action-link"
                          >
                            View Students
                          </Link>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default DomainList;
