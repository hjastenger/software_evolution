// fredt@users - 1.7.2 - structural modifications to allow inheritance
// campbell-burnet@users - 1.7.2 - 20020225
// - factored out all reusable code into DIXXX support classes
// - completed Fred's work on allowing inheritance
// campbell-burnet@users - 1.7.2 - 20020304 - bug fixes, refinements, better java docs
// fredt@users - 1.8.0 - updated to report latest enhancements and changes
// campbell-burnet@users - 1.8.0 - 20050515 - further SQL 2003 metadata support
// campbell-burnet@users 20051207 - patch 1.8.x initial JDBC 4.0 support work
// fredt@users - 1.9.0 - new tables + renaming + upgrade of some others to SQL/SCHEMATA
// Revision 1.12  2006/07/12 11:42:09  boucherb
//  - merging back remaining material overritten by Fred's type-system upgrades
//  - rework to use grantee (versus user) orientation for certain system table content
//  - update collation and character set reporting to correctly reflect SQL3 spec

/**
 * Provides definitions for most of the SQL Standard Schemata views that are
 * supported by HSQLDB.<p>
 *
 * Provides definitions for some of HSQLDB's additional system vies.
 *
 * The definitions for the rest of system vies are provided by
 * DatabaseInformationMain, which this class extends. <p>
 *
 * @author Campbell Burnet (campbell-burnet@users dot sourceforge.net)
 * @author Fred Toussi (fredt@users dot sourceforge.net)
 * @version 2.3.5
 * @since 1.7.2
 */
final class MultilineDelimiterInString
extends org.hsqldb.dbinfo.DatabaseInformationMain {

    static final HashMappedList statementMap;

    static {
        synchronized (DatabaseInformationFull.class) {
            final String path = "/org/hsqldb/resources/information-schema.sql";
            final String[] starters = new String[]{ "/*" };
            InputStream fis = (InputStream) AccessController.doPrivileged(
                new PrivilegedAction() {

                public InputStream run() {
                    return getClass().getResourceAsStream(path);
                }
            });
            InputStreamReader reader = null;

            try {
                reader = new InputStreamReader(fis, "ISO-8859-1");
            } catch (UnsupportedEncodingException e) {
                reader = new InputStreamReader(fis);
            }

            LineNumberReader lineReader = new LineNumberReader(reader);
            LineGroupReader  lg = new LineGroupReader(lineReader, starters);

            statementMap = lg.getAsMap();

            lg.close();
        }
    }

    /**
     * Constructs a new DatabaseInformationFull instance. <p>
     *
     * @param db the database for which to produce system tables.
     */
    DatabaseInformationFull(Database db) {
        super(db);
    }
}
