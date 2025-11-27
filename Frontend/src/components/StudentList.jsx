import "../Styles/StudentList.css";
import React, { useState, useEffect, useContext } from "react";
import { useParams, useNavigate, useLocation } from "react-router-dom";
import { UserContext } from "../UserContext";
import { fetchStudents } from "../utils/api";

const StudentList = () => {
  const { courseId } = useParams();
  const [students, setStudents] = useState([]);
  const navigate = useNavigate();
  const location = useLocation();
  const { user, setUser } = useContext(UserContext);

  const handleLogout = () => {
    setUser(null);
    localStorage.removeItem("user");
    navigate("/");
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetchStudents(courseId);
        setStudents(response.data);
      } catch (error) {
        console.error("Error fetching students:", error);
      }
    };
    fetchData();
  }, [courseId]);

  const goBack = () => {
    if (location.state && location.state.previousDomainId) {
      navigate("/domain", {
        state: {
          domainId: location.state.previousDomainId,
          domainName: location.state.previousDomainName,
        },
      });
    } else {
      navigate("/domain");
    }
  };

  return (
    <div className="student-list-page">
      <div className="app-header">
        <div className="header-left">
          <button className="back-btn-header" onClick={goBack}>
            <i className="fas fa-arrow-left"></i> Back
          </button>
          <h1>Student List <span className="course-id-badge">Course {courseId}</span></h1>
        </div>
        <button className="logout-btn" onClick={handleLogout}>
          Logout
        </button>
      </div>

      <div className="main-content-container">
        <div className="table-card">
          <div className="card-header">
            <h2>Enrolled Students</h2>
            <span className="student-count-badge">{students.length} Students</span>
          </div>

          {students.length === 0 ? (
            <div className="empty-state">
              <div className="empty-icon">
                <i className="fas fa-user-graduate"></i>
              </div>
              <h3>No students enrolled yet</h3>
            </div>
          ) : (
            <div className="table-responsive">
              <table className="corporate-table">
                <thead>
                  <tr>
                    <th className="col-id">ID</th>
                    <th className="col-name">Name</th>
                    <th className="col-roll">Roll Number</th>
                    <th className="col-email">Email</th>
                  </tr>
                </thead>
                <tbody>
                  {students.map((student) => (
                    <tr key={student.id}>
                      <td className="col-id"><span className="id-badge">#{student.id}</span></td>
                      <td className="col-name">
                        <div className="student-name-cell">
                          <div className="avatar-circle">{student.name.charAt(0)}</div>
                          {student.name}
                        </div>
                      </td>
                      <td className="col-roll"><span className="roll-badge">{student.rno}</span></td>
                      <td className="col-email">{student.email}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default StudentList;
